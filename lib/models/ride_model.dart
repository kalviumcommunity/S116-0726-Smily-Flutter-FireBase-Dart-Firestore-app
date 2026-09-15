import 'package:cloud_firestore/cloud_firestore.dart';

class RideModel {
  final String id;
  final String passengerId;
  final String passengerName;
  final String passengerPhone;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final String pickupLocation;
  final String dropLocation;
  final String vehicleType; // 'auto', 'cab'
  final double fare;
  final String status; // 'requested', 'accepted', 'ongoing', 'completed', 'cancelled'
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;

  RideModel({
    required this.id,
    required this.passengerId,
    required this.passengerName,
    required this.passengerPhone,
    this.driverId,
    this.driverName,
    this.driverPhone,
    required this.pickupLocation,
    required this.dropLocation,
    required this.vehicleType,
    required this.fare,
    this.status = 'requested',
    DateTime? createdAt,
    this.acceptedAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passengerId': passengerId,
      'passengerName': passengerName,
      'passengerPhone': passengerPhone,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhone': driverPhone,
      'pickupLocation': pickupLocation,
      'dropLocation': dropLocation,
      'vehicleType': vehicleType,
      'fare': fare,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'acceptedAt': acceptedAt != null ? Timestamp.fromDate(acceptedAt!) : null,
      'completedAt': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }

  factory RideModel.fromMap(Map<String, dynamic> map, String docId) {
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is String) {
        return DateTime.tryParse(value) ?? DateTime.now();
      } else if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return DateTime.now();
    }

    DateTime? parseNullableDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value);
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      return null;
    }

    return RideModel(
      id: docId,
      passengerId: map['passengerId'] ?? '',
      passengerName: map['passengerName'] ?? 'Passenger',
      passengerPhone: map['passengerPhone'] ?? '',
      driverId: map['driverId'],
      driverName: map['driverName'],
      driverPhone: map['driverPhone'],
      pickupLocation: map['pickupLocation'] ?? '',
      dropLocation: map['dropLocation'] ?? '',
      vehicleType: map['vehicleType'] ?? 'auto',
      fare: (map['fare'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] ?? 'requested',
      createdAt: parseDate(map['createdAt']),
      acceptedAt: parseNullableDate(map['acceptedAt']),
      completedAt: parseNullableDate(map['completedAt']),
    );
  }

  RideModel copyWith({
    String? id,
    String? passengerId,
    String? passengerName,
    String? passengerPhone,
    String? driverId,
    String? driverName,
    String? driverPhone,
    String? pickupLocation,
    String? dropLocation,
    String? vehicleType,
    double? fare,
    String? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? completedAt,
  }) {
    return RideModel(
      id: id ?? this.id,
      passengerId: passengerId ?? this.passengerId,
      passengerName: passengerName ?? this.passengerName,
      passengerPhone: passengerPhone ?? this.passengerPhone,
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      driverPhone: driverPhone ?? this.driverPhone,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropLocation: dropLocation ?? this.dropLocation,
      vehicleType: vehicleType ?? this.vehicleType,
      fare: fare ?? this.fare,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
