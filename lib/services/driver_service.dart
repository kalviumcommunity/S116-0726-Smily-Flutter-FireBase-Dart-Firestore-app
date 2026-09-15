import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

class DriverService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  /// Toggles driver online / offline status
  Future<void> toggleOnlineStatus(String driverId, bool isOnline) async {
    try {
      if (Firebase.apps.isEmpty) return;
      await _firestore
          .collection(AppConstants.collectionDrivers)
          .doc(driverId)
          .update({
        'isOnline': isOnline,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to update online status: ${e.toString()}';
    }
  }

  /// Updates driver current zone/stand
  Future<void> updateDriverZone(String driverId, String zone) async {
    try {
      if (Firebase.apps.isEmpty) return;
      await _firestore
          .collection(AppConstants.collectionDrivers)
          .doc(driverId)
          .update({
        'currentZone': zone,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to update driver zone: ${e.toString()}';
    }
  }

  /// Streams driver details in real-time
  Stream<DriverDetails?> streamDriverDetails(String driverId) {
    try {
      if (Firebase.apps.isEmpty) return Stream.value(null);
      return _firestore
          .collection(AppConstants.collectionDrivers)
          .doc(driverId)
          .snapshots()
          .map((snapshot) {
        if (!snapshot.exists || snapshot.data() == null) return null;
        return DriverDetails.fromMap(snapshot.data()!, snapshot.id);
      });
    } catch (_) {
      return Stream.value(null);
    }
  }

  /// Streams list of all online drivers
  Stream<List<DriverDetails>> streamOnlineDrivers() {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);
      return _firestore
          .collection(AppConstants.collectionDrivers)
          .where('isOnline', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => DriverDetails.fromMap(doc.data(), doc.id))
            .toList();
      });
    } catch (_) {
      return Stream.value([]);
    }
  }
}
