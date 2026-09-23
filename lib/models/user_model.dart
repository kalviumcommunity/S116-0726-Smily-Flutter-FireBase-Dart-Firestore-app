import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String role; // 'passenger', 'driver', 'admin'
  final bool isActive;
  final DateTime createdAt;
  final DriverDetails? driverDetails;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    this.isActive = true,
    DateTime? createdAt,
    this.driverDetails,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      if (driverDetails != null) 'driverDetails': driverDetails!.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String uid, {DriverDetails? driverDetails}) {
    DateTime parseCreatedAt(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      } else if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } else if (value is DateTime) {
        return value;
      }
      return DateTime.now();
    }

    DriverDetails? details = driverDetails;
    if (details == null && map['driverDetails'] != null && map['driverDetails'] is Map) {
      details = DriverDetails.fromMap(Map<String, dynamic>.from(map['driverDetails']), uid);
    }

    return UserModel(
      uid: uid,
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'passenger',
      isActive: map['isActive'] ?? true,
      createdAt: parseCreatedAt(map['createdAt']),
      driverDetails: details,
    );
  }
}

class DriverDetails {
  final String uid;
  final String vehicleType; // 'auto', 'cab'
  final String vehicleRegistrationNumber;
  final String unionPermitNumber;
  final bool isOnline;
  final bool isBusy;
  final String? currentZone;

  DriverDetails({
    this.uid = '',
    required this.vehicleType,
    required this.vehicleRegistrationNumber,
    required this.unionPermitNumber,
    this.isOnline = false,
    this.isBusy = false,
    this.currentZone,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleType': vehicleType,
      'vehicleRegistrationNumber': vehicleRegistrationNumber,
      'unionPermitNumber': unionPermitNumber,
      'isOnline': isOnline,
      'isBusy': isBusy,
      'currentZone': currentZone,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  factory DriverDetails.fromMap(Map<String, dynamic> map, String uid) {
    return DriverDetails(
      uid: uid,
      vehicleType: map['vehicleType'] ?? 'auto',
      vehicleRegistrationNumber: map['vehicleRegistrationNumber'] ?? '',
      unionPermitNumber: map['unionPermitNumber'] ?? '',
      isOnline: map['isOnline'] ?? false,
      isBusy: map['isBusy'] ?? false,
      currentZone: map['currentZone'],
    );
  }
}
