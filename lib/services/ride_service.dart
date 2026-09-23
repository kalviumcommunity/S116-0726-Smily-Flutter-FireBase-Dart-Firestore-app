import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride_model.dart';

class RideService {
  static final RideService _instance = RideService._internal();
  factory RideService() => _instance;
  RideService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Creates a new ride request document in Cloud Firestore
  Future<RideModel> createRideRequest({
    required String passengerId,
    required String passengerName,
    required String passengerPhone,
    required String pickupLocation,
    required String dropLocation,
    required String vehicleType,
    required double fare,
  }) async {
    final docRef = _firestore.collection('rides').doc();
    final now = DateTime.now();

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
      createdAt: now,
    );

    await docRef.set(ride.toMap());
    return ride;
  }

  /// Streams available ride requests for drivers filtered by vehicleType
  Stream<List<RideModel>> streamAvailableRides({String? vehicleType}) {
    return _firestore
        .collection('rides')
        .where('status', isEqualTo: 'requested')
        .snapshots()
        .map((snapshot) {
      final rides = snapshot.docs
          .map((doc) => RideModel.fromMap(doc.data(), doc.id))
          .toList();

      if (vehicleType != null && vehicleType.isNotEmpty) {
        return rides.where((r) => r.vehicleType == vehicleType).toList();
      }
      return rides;
    });
  }

  /// Streams rides belonging to a specific passenger
  Stream<List<RideModel>> streamPassengerRides(String passengerId) {
    return _firestore
        .collection('rides')
        .where('passengerId', isEqualTo: passengerId)
        .snapshots()
        .map((snapshot) {
      final rides = snapshot.docs
          .map((doc) => RideModel.fromMap(doc.data(), doc.id))
          .toList();
      rides.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return rides;
    });
  }

  /// Streams rides accepted or completed by a specific driver
  Stream<List<RideModel>> streamDriverRides(String driverId) {
    return _firestore
        .collection('rides')
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .map((snapshot) {
      final rides = snapshot.docs
          .map((doc) => RideModel.fromMap(doc.data(), doc.id))
          .toList();
      rides.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return rides;
    });
  }

  /// Accepts a ride request by a driver
  Future<void> acceptRide({
    required String rideId,
    required String driverId,
    required String driverName,
    String? driverPhone,
  }) async {
    await _firestore.collection('rides').doc(rideId).update({
      'driverId': driverId,
      'driverName': driverName,
      'driverPhone': driverPhone ?? '',
      'status': 'accepted',
      'acceptedAt': Timestamp.now(),
    });
  }

  /// Updates ride status ('ongoing', 'completed', 'cancelled')
  Future<void> updateRideStatus({
    required String rideId,
    required String newStatus,
    String? driverId,
  }) async {
    final updateData = <String, dynamic>{
      'status': newStatus,
    };
    if (newStatus == 'completed') {
      updateData['completedAt'] = Timestamp.now();
    }
    await _firestore.collection('rides').doc(rideId).update(updateData);
  }

  /// Single ride document fetch
  Future<RideModel?> getRideDetails(String rideId) async {
    try {
      final doc = await _firestore.collection('rides').doc(rideId).get();
      if (doc.exists && doc.data() != null) {
        return RideModel.fromMap(doc.data()!, doc.id);
      }
    } catch (_) {}
    return null;
  }
}

