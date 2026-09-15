import 'package:flutter_test/flutter_test.dart';
import 'package:union_ride/models/user_model.dart';
import 'package:union_ride/models/ride_model.dart';

void main() {
  group('Backend Models Tests', () {
    test('UserModel map serialization and deserialization works correctly', () {
      final now = DateTime.now();
      final user = UserModel(
        uid: 'test_uid_123',
        fullName: 'Test User',
        phoneNumber: '+919876543210',
        email: 'test@example.com',
        role: 'passenger',
        isActive: true,
        createdAt: now,
      );

      final map = user.toMap();
      expect(map['uid'], 'test_uid_123');
      expect(map['fullName'], 'Test User');
      expect(map['email'], 'test@example.com');
      expect(map['role'], 'passenger');

      final restored = UserModel.fromMap(map, 'test_uid_123');
      expect(restored.uid, 'test_uid_123');
      expect(restored.fullName, 'Test User');
      expect(restored.email, 'test@example.com');
    });

    test('DriverDetails model map serialization works correctly', () {
      final driverDetails = DriverDetails(
        uid: 'driver_uid_456',
        vehicleType: 'auto',
        vehicleRegistrationNumber: 'MH12AB1234',
        unionPermitNumber: 'UP-998877',
        isOnline: true,
        isBusy: false,
      );

      final map = driverDetails.toMap();
      expect(map['vehicleType'], 'auto');
      expect(map['vehicleRegistrationNumber'], 'MH12AB1234');
      expect(map['unionPermitNumber'], 'UP-998877');
      expect(map['isOnline'], true);

      final restored = DriverDetails.fromMap(map, 'driver_uid_456');
      expect(restored.vehicleType, 'auto');
      expect(restored.vehicleRegistrationNumber, 'MH12AB1234');
      expect(restored.unionPermitNumber, 'UP-998877');
      expect(restored.isOnline, true);
    });

    test('RideModel map serialization and deserialization works correctly', () {
      final now = DateTime.now();
      final ride = RideModel(
        id: 'ride_101',
        passengerId: 'p_100',
        passengerName: 'Passenger One',
        passengerPhone: '+919999999999',
        pickupLocation: 'Station Road',
        dropLocation: 'Airport Road',
        vehicleType: 'cab',
        fare: 250.0,
        status: 'requested',
        createdAt: now,
      );

      final map = ride.toMap();
      expect(map['id'], 'ride_101');
      expect(map['passengerId'], 'p_100');
      expect(map['vehicleType'], 'cab');
      expect(map['fare'], 250.0);
      expect(map['status'], 'requested');

      final restored = RideModel.fromMap(map, 'ride_101');
      expect(restored.id, 'ride_101');
      expect(restored.passengerId, 'p_100');
      expect(restored.vehicleType, 'cab');
      expect(restored.fare, 250.0);
      expect(restored.status, 'requested');
    });
  });
}
