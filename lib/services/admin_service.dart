import 'dart:async';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';

class AdminService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  final List<UserModel> _users = [
    UserModel(
      uid: 'user_1',
      fullName: 'Ramesh Kumar',
      phoneNumber: '+91 9876543210',
      email: 'ramesh@example.com',
      role: AppConstants.rolePassenger,
    ),
    UserModel(
      uid: 'driver_1',
      fullName: 'Suresh Patil',
      phoneNumber: '+91 9876543211',
      email: 'suresh@example.com',
      role: AppConstants.roleDriver,
      driverDetails: DriverDetails(
        vehicleType: 'auto',
        vehicleRegistrationNumber: 'KA-01-F-1234',
        unionPermitNumber: 'UP-1002',
        isOnline: true,
      ),
    ),
  ];

  final StreamController<List<UserModel>> _usersController =
      StreamController<List<UserModel>>.broadcast();

  /// Stream list of all registered users
  Stream<List<UserModel>> streamAllUsers() {
    return Stream.value(_users);
  }

  /// Stream list of all drivers with details
  Stream<List<UserModel>> streamAllDrivers() {
    return Stream.value(
      _users.where((u) => u.role == AppConstants.roleDriver).toList(),
    );
  }

  /// Toggle user active status (activate/deactivate account)
  Future<void> toggleUserAccountStatus(String uid, bool isActive) async {
    final index = _users.indexWhere((u) => u.uid == uid);
    if (index != -1) {
      _users[index] = _users[index].copyWith(isActive: isActive);
      _usersController.add(_users);
    }
  }

  /// Calculate real-time dashboard metrics
  Future<Map<String, int>> getDashboardMetrics() async {
    final activeDrivers = _users
        .where((u) => u.role == AppConstants.roleDriver && (u.driverDetails?.isOnline ?? false))
        .length;

    return {
      'totalUsers': _users.length,
      'activeDrivers': activeDrivers,
      'activeRides': 1,
      'completedRides': 5,
    };
  }
}
