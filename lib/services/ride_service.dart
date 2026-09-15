import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride_model.dart';
import '../core/constants/app_constants.dart';

class RideService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  /// Creates a new ride request in Firestore
  Future<RideModel> createRideRequest({
    required String passengerId,
    required String passengerName,
    required String passengerPhone,
    required String pickupLocation,
    required String dropLocation,
    required String vehicleType,
    required double fare,
  }) async {
    try {
      if (Firebase.apps.isEmpty) {
        return RideModel(
          id: 'mock_ride_id',
          passengerId: passengerId,
          passengerName: passengerName,
          passengerPhone: passengerPhone,
          pickupLocation: pickupLocation,
          dropLocation: dropLocation,
          vehicleType: vehicleType,
          fare: fare,
        );
      }

      final docRef = _firestore.collection(AppConstants.collectionRides).doc();

      final ride = RideModel(
        id: docRef.id,
        passengerId: passengerId,
        passengerName: passengerName,
        passengerPhone: passengerPhone,
        pickupLocation: pickupLocation,
        dropLocation: dropLocation,
        vehicleType: vehicleType,
        fare: fare,
        status: 'requested',
        createdAt: DateTime.now(),
      );

      await docRef.set(ride.toMap());
      return ride;
    } catch (e) {
      throw 'Failed to create ride request: ${e.toString()}';
    }
  }

  /// Streams available ride requests for drivers filtered by vehicleType
  Stream<List<RideModel>> streamAvailableRides({String? vehicleType}) {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);

      Query query = _firestore
          .collection(AppConstants.collectionRides)
          .where('status', isEqualTo: 'requested');

      if (vehicleType != null && vehicleType.isNotEmpty) {
        query = query.where('vehicleType', isEqualTo: vehicleType);
      }

      return query.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => RideModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      });
    } catch (_) {
      return Stream.value([]);
    }
  }

  /// Streams rides belonging to a specific passenger
  Stream<List<RideModel>> streamPassengerRides(String passengerId) {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);

      return _firestore
          .collection(AppConstants.collectionRides)
          .where('passengerId', isEqualTo: passengerId)
          .snapshots()
          .map((snapshot) {
        final rides = snapshot.docs
            .map((doc) => RideModel.fromMap(doc.data(), doc.id))
            .toList();
        rides.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return rides;
      });
    } catch (_) {
      return Stream.value([]);
    }
  }

  /// Streams rides accepted or completed by a specific driver
  Stream<List<RideModel>> streamDriverRides(String driverId) {
    try {
      if (Firebase.apps.isEmpty) return Stream.value([]);

      return _firestore
          .collection(AppConstants.collectionRides)
          .where('driverId', isEqualTo: driverId)
          .snapshots()
          .map((snapshot) {
        final rides = snapshot.docs
            .map((doc) => RideModel.fromMap(doc.data(), doc.id))
            .toList();
        rides.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return rides;
      });
    } catch (_) {
      return Stream.value([]);
    }
  }

  /// Accepts a ride request by a driver
  Future<void> acceptRide({
    required String rideId,
    required String driverId,
    required String driverName,
    String? driverPhone,
  }) async {
    try {
      final batch = _firestore.batch();
      final rideRef = _firestore.collection(AppConstants.collectionRides).doc(rideId);
      final driverRef = _firestore.collection(AppConstants.collectionDrivers).doc(driverId);

      batch.update(rideRef, {
        'driverId': driverId,
        'driverName': driverName,
        'driverPhone': driverPhone ?? '',
        'status': 'accepted',
        'acceptedAt': Timestamp.fromDate(DateTime.now()),
      });

      batch.update(driverRef, {
        'isBusy': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await batch.commit();
    } catch (e) {
      throw 'Failed to accept ride: ${e.toString()}';
    }
  }

  /// Updates ride status ('ongoing', 'completed', 'cancelled')
  Future<void> updateRideStatus({
    required String rideId,
    required String newStatus,
    String? driverId,
  }) async {
    try {
      final batch = _firestore.batch();
      final rideRef = _firestore.collection(AppConstants.collectionRides).doc(rideId);

      final Map<String, dynamic> updateData = {'status': newStatus};
      if (newStatus == 'completed') {
        updateData['completedAt'] = Timestamp.fromDate(DateTime.now());
      }

      batch.update(rideRef, updateData);

      if ((newStatus == 'completed' || newStatus == 'cancelled') && driverId != null && driverId.isNotEmpty) {
        final driverRef = _firestore.collection(AppConstants.collectionDrivers).doc(driverId);
        batch.update(driverRef, {
          'isBusy': false,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    } catch (e) {
      throw 'Failed to update ride status: ${e.toString()}';
    }
  }

  /// Single ride document fetch
  Future<RideModel?> getRideDetails(String rideId) async {
    try {
      final doc = await _firestore.collection(AppConstants.collectionRides).doc(rideId).get();
      if (!doc.exists || doc.data() == null) return null;
      return RideModel.fromMap(doc.data()!, doc.id);
    } catch (e) {
      return null;
    }
  }
}
