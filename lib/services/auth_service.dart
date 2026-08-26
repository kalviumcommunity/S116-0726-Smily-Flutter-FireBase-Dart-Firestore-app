import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Current authenticated user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Registers a new user (Passenger, Driver, or Admin)
  Future<UserModel> registerUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String role,
    DriverDetails? driverDetails,
  }) async {
    try {
      // 1. Create auth user with Firebase Auth
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final String uid = credential.user!.uid;

      // 2. Build User Model
      final user = UserModel(
        uid: uid,
        fullName: fullName.trim(),
        phoneNumber: phoneNumber.trim(),
        email: email.trim(),
        role: role,
        isActive: true,
        driverDetails: driverDetails,
      );

      // 3. Save User metadata to Firestore under users/{uid}
      await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(uid)
          .set(user.toMap());

      // 4. If Driver, save driver-specific info under drivers/{uid}
      if (role == AppConstants.roleDriver && driverDetails != null) {
        final driverData = DriverDetails(
          uid: uid,
          vehicleType: driverDetails.vehicleType,
          vehicleRegistrationNumber: driverDetails.vehicleRegistrationNumber,
          unionPermitNumber: driverDetails.unionPermitNumber,
          isOnline: false,
          isBusy: false,
        );

        await _firestore
            .collection(AppConstants.collectionDrivers)
            .doc(uid)
            .set(driverData.toMap());
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred during registration. Please try again.';
    }
  }

  String _parseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'The password provided is too weak. Minimum 6 characters required.';
      case 'operation-not-allowed':
        return 'Registration is currently disabled.';
      default:
        return e.message ?? 'Registration failed. Please check your credentials.';
    }
  }
}
