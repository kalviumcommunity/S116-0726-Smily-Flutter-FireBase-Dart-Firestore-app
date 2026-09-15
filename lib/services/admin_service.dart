import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

class AdminService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  /// Stream list of all registered users
  Stream<List<UserModel>> streamAllUsers() {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);
      return _firestore
          .collection(AppConstants.collectionUsers)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data(), doc.id))
            .toList();
      });
    } catch (_) {
      return Stream.value([]);
    }
  }

  /// Stream list of all drivers with details
  Stream<List<UserModel>> streamAllDrivers() {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);
      return _firestore
          .collection(AppConstants.collectionUsers)
          .where('role', isEqualTo: AppConstants.roleDriver)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => UserModel.fromMap(doc.data(), doc.id))
            .toList();
      });
    } catch (_) {
      return Stream.value([]);
    }
  }

  /// Toggle user active status (activate/deactivate account)
  Future<void> toggleUserAccountStatus(String uid, bool isActive) async {
    try {
      if (Firebase.apps.isEmpty) return;
      await _firestore
          .collection(AppConstants.collectionUsers)
          .doc(uid)
          .update({'isActive': isActive});
    } catch (e) {
      throw 'Failed to update user account status: ${e.toString()}';
    }
  }

  /// Calculate real-time dashboard metrics
  Future<Map<String, int>> getDashboardMetrics() async {
    try {
      if (Firebase.apps.isEmpty) {
        return {
          'totalUsers': 0,
          'activeDrivers': 0,
          'activeRides': 0,
          'completedRides': 0,
        };
      }

      final usersSnap = await _firestore.collection(AppConstants.collectionUsers).get();
      final driversSnap = await _firestore
          .collection(AppConstants.collectionDrivers)
          .where('isOnline', isEqualTo: true)
          .get();
      final activeRidesSnap = await _firestore
          .collection(AppConstants.collectionRides)
          .where('status', whereIn: ['requested', 'accepted', 'ongoing'])
          .get();
      final completedRidesSnap = await _firestore
          .collection(AppConstants.collectionRides)
          .where('status', isEqualTo: 'completed')
          .get();

      return {
        'totalUsers': usersSnap.docs.length,
        'activeDrivers': driversSnap.docs.length,
        'activeRides': activeRidesSnap.docs.length,
        'completedRides': completedRidesSnap.docs.length,
      };
    } catch (e) {
      return {
        'totalUsers': 0,
        'activeDrivers': 0,
        'activeRides': 0,
        'completedRides': 0,
      };
    }
  }
}
