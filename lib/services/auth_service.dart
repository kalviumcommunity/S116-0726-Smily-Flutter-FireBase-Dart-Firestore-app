import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  final _authStateController = StreamController<UserModel?>.broadcast();

  AuthService._internal() {
    _auth.authStateChanges().listen((User? firebaseUser) async {
      if (firebaseUser == null) {
        _currentUser = null;
        _authStateController.add(null);
      } else {
        _currentUser = await fetchUserData(firebaseUser.uid);
        _authStateController.add(_currentUser);
      }
    });
  }

  UserModel? get currentUser => _currentUser;
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  /// Fetches UserModel from Firestore document `users/{uid}`
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!, uid);
      }
    } catch (e) {
      // Fallback or error logging
    }
    return null;
  }

  Future<UserModel> login({required String email, required String password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user!.uid;

    UserModel? userModel = await fetchUserData(uid);
    if (userModel == null) {
      userModel = UserModel(
        uid: uid,
        fullName: credential.user?.displayName ?? 'User',
        phoneNumber: credential.user?.phoneNumber ?? '',
        email: email,
        role: 'passenger',
      );
      await _firestore.collection('users').doc(uid).set(userModel.toMap());
    }

    _currentUser = userModel;
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<UserModel> registerPassenger({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user!.uid;

    final newUser = UserModel(
      uid: uid,
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      role: 'passenger',
    );

    await _firestore.collection('users').doc(uid).set(newUser.toMap());

    _currentUser = newUser;
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<UserModel> registerDriver({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String vehicleType,
    required String vehicleRegistrationNumber,
    required String unionPermitNumber,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    final uid = credential.user!.uid;

    final driverDetails = DriverDetails(
      uid: uid,
      vehicleType: vehicleType,
      vehicleRegistrationNumber: vehicleRegistrationNumber,
      unionPermitNumber: unionPermitNumber,
      isOnline: false,
    );

    final newUser = UserModel(
      uid: uid,
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      role: 'driver',
      driverDetails: driverDetails,
    );

    await _firestore.collection('users').doc(uid).set(newUser.toMap());

    _currentUser = newUser;
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<void> signOut() async {
    await _auth.signOut();che
    _currentUser = null;
    _authStateController.add(null);
  }
}

