import 'dart:async';
import '../models/ride_model.dart';

class RideService {
  static final RideService _instance = RideService._internal();
  factory RideService() => _instance;
  RideService._internal();

  final List<RideModel> _rides = [];
  final StreamController<List<RideModel>> _ridesController =
      StreamController<List<RideModel>>.broadcast();

  void _notify() {
    _ridesController.add(List.from(_rides));
  }

  /// Creates a new ride request in memory
  Future<RideModel> createRideRequest({
    required String passengerId,
    required String passengerName,
    required String passengerPhone,
    required String pickupLocation,
    required String dropLocation,
    required String vehicleType,
    required double fare,
  }) async {
    final ride = RideModel(
      id: 'ride_${DateTime.now().millisecondsSinceEpoch}',
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

    _rides.add(ride);
    _notify();
    return ride;
  }

  /// Streams available ride requests for drivers filtered by vehicleType
  Stream<List<RideModel>> streamAvailableRides({String? vehicleType}) {
    return _ridesController.stream.map((rides) {
      return rides.where((r) {
        final matchesStatus = r.status == 'requested';
        final matchesVehicle = vehicleType == null || vehicleType.isEmpty || r.vehicleType == vehicleType;
        return matchesStatus && matchesVehicle;
      }).toList();
    });
  }

  /// Streams rides belonging to a specific passenger
  Stream<List<RideModel>> streamPassengerRides(String passengerId) {
    return _ridesController.stream.map((rides) {
      final filtered = rides.where((r) => r.passengerId == passengerId).toList();
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return filtered;
    });
  }

  /// Streams rides accepted or completed by a specific driver
  Stream<List<RideModel>> streamDriverRides(String driverId) {
    return _ridesController.stream.map((rides) {
      final filtered = rides.where((r) => r.driverId == driverId).toList();
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return filtered;
    });
  }

  /// Accepts a ride request by a driver
  Future<void> acceptRide({
    required String rideId,
    required String driverId,
    required String driverName,
    String? driverPhone,
  }) async {
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index != -1) {
      _rides[index] = _rides[index].copyWith(
        driverId: driverId,
        driverName: driverName,
        driverPhone: driverPhone ?? '',
        status: 'accepted',
        acceptedAt: DateTime.now(),
      );
      _notify();
    }
  }

  /// Updates ride status ('ongoing', 'completed', 'cancelled')
  Future<void> updateRideStatus({
    required String rideId,
    required String newStatus,
    String? driverId,
  }) async {
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index != -1) {
      _rides[index] = _rides[index].copyWith(
        status: newStatus,
        completedAt: newStatus == 'completed' ? DateTime.now() : _rides[index].completedAt,
      );
      _notify();
    }
  }

  /// Single ride document fetch
  Future<RideModel?> getRideDetails(String rideId) async {
    try {
      return _rides.firstWhere((r) => r.id == rideId);
    } catch (_) {
      return null;
    }
  }
}
