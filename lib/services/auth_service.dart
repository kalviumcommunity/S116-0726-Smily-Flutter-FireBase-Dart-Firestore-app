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

  /// Authenticates an existing user and returns their UserModel profile from Firestore
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final String uid = credential.user!.uid;
      final userModel = await getUserProfile(uid);

      if (userModel == null) {
        throw 'User profile not found in database. Please contact support.';
      }

      if (!userModel.isActive) {
        await _auth.signOut();
        throw 'Your account has been deactivated. Please contact support.';
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthException(e);
    } catch (e) {
      if (e is String) rethrow;
      throw 'An unexpected error occurred during login. Please try again.';
    }
  }

  /// Fetches user profile from Firestore by UID
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(uid)
          .get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      DriverDetails? driverDetails;
      final userData = doc.data()!;
      if (userData['role'] == AppConstants.roleDriver) {
        final driverDoc = await _firestore
            .collection(AppConstants.collectionDrivers)
            .doc(uid)
            .get();
        if (driverDoc.exists && driverDoc.data() != null) {
          driverDetails = DriverDetails.fromMap(driverDoc.data()!, uid);
        }
      }

      return UserModel.fromMap(userData, uid);
    } catch (e) {
      return null;
    }
  }

  /// Sends password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _parseAuthException(e);
    } catch (e) {
      throw 'Failed to send password reset email. Please try again.';
    }
  }

  /// Signs out the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _parseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'email-already-in-use':
        return 'An account already exists for this email address.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'The password provided is too weak. Minimum 6 characters required.';
      case 'operation-not-allowed':
        return 'Operation currently disabled.';
      case 'too-many-requests':
        return 'Too many unsuccessful attempts. Please try again later.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}
