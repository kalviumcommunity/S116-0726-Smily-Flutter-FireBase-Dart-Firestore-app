import 'package:cloud_firestore/cloud_firestore.dart';

class ZoneModel {
  final String id;
  final String zoneName;
  final int activeDriversCount;
  final int pendingRequestsCount;
  final int totalCompletedToday;
  final DateTime lastUpdated;

  ZoneModel({
    required this.id,
    required this.zoneName,
    this.activeDriversCount = 0,
    this.pendingRequestsCount = 0,
    this.totalCompletedToday = 0,
    DateTime? lastUpdated,
  }) : lastUpdated = lastUpdated ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'zoneName': zoneName,
      'activeDriversCount': activeDriversCount,
      'pendingRequestsCount': pendingRequestsCount,
      'totalCompletedToday': totalCompletedToday,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
    };
  }

  factory ZoneModel.fromMap(Map<String, dynamic> map, String docId) {
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
      if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return ZoneModel(
      id: docId,
      zoneName: map['zoneName'] ?? docId,
      activeDriversCount: (map['activeDriversCount'] as num?)?.toInt() ?? 0,
      pendingRequestsCount: (map['pendingRequestsCount'] as num?)?.toInt() ?? 0,
      totalCompletedToday: (map['totalCompletedToday'] as num?)?.toInt() ?? 0,
      lastUpdated: parseDate(map['lastUpdated']),
    );
  }
}
