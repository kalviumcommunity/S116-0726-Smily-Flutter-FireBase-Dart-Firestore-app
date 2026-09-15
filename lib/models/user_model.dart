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
      }
      return DateTime.now();
    }

    return UserModel(
      uid: uid,
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'passenger',
      isActive: map['isActive'] ?? true,
      createdAt: parseCreatedAt(map['createdAt']),
      driverDetails: driverDetails,
    );
  }

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? role,
    bool? isActive,
    DateTime? createdAt,
    DriverDetails? driverDetails,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      driverDetails: driverDetails ?? this.driverDetails,
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
      'updatedAt': FieldValue.serverTimestamp(),
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

  DriverDetails copyWith({
    String? uid,
    String? vehicleType,
    String? vehicleRegistrationNumber,
    String? unionPermitNumber,
    bool? isOnline,
    bool? isBusy,
    String? currentZone,
  }) {
    return DriverDetails(
      uid: uid ?? this.uid,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleRegistrationNumber: vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
      unionPermitNumber: unionPermitNumber ?? this.unionPermitNumber,
      isOnline: isOnline ?? this.isOnline,
      isBusy: isBusy ?? this.isBusy,
      currentZone: currentZone ?? this.currentZone,
    );
  }
}