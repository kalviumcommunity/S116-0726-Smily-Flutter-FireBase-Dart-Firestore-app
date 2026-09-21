import 'dart:async';
import '../models/user_model.dart';

class DriverService {
  static final DriverService _instance = DriverService._internal();
  factory DriverService() => _instance;
  DriverService._internal();

  final Map<String, DriverDetails> _drivers = {};
  final StreamController<List<DriverDetails>> _driversController =
      StreamController<List<DriverDetails>>.broadcast();

  void _notify() {
    _driversController.add(_drivers.values.toList());
  }

  /// Toggles driver online / offline status
  Future<void> toggleOnlineStatus(String driverId, bool isOnline) async {
    final driver = _drivers[driverId] ??
        DriverDetails(
          uid: driverId,
          vehicleType: 'auto',
          vehicleRegistrationNumber: 'KA-01-AB-1234',
          unionPermitNumber: 'UP-9988',
        );
    _drivers[driverId] = driver.copyWith(isOnline: isOnline);
    _notify();
  }

  /// Updates driver current zone/stand
  Future<void> updateDriverZone(String driverId, String zone) async {
    final driver = _drivers[driverId] ??
        DriverDetails(
          uid: driverId,
          vehicleType: 'auto',
          vehicleRegistrationNumber: 'KA-01-AB-1234',
          unionPermitNumber: 'UP-9988',
        );
    _drivers[driverId] = driver.copyWith(currentZone: zone);
    _notify();
  }

  /// Streams driver details in real-time
  Stream<DriverDetails?> streamDriverDetails(String driverId) {
    return _driversController.stream.map((list) {
      return _drivers[driverId];
    });
  }

  /// Streams list of all online drivers
  Stream<List<DriverDetails>> streamOnlineDrivers() {
    return _driversController.stream.map((list) {
      return list.where((d) => d.isOnline).toList();
    });
  }
}
