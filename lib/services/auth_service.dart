import 'dart:async';
import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  final _authStateController = StreamController<UserModel?>.broadcast();

  UserModel? get currentUser => _currentUser;
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  Future<UserModel> login({required String email, required String password}) async {
    _currentUser = UserModel(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: 'Test User',
      phoneNumber: '+91 9876543210',
      email: email,
      role: 'passenger',
    );
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<UserModel> registerPassenger({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    _currentUser = UserModel(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      role: 'passenger',
    );
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<UserModel> registerDriver({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String vehicleType,
    required String vehicleRegistrationNumber,
    required String unionPermitNumber,
  }) async {
    _currentUser = UserModel(
      uid: 'driver_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      role: 'driver',
      driverDetails: DriverDetails(
        vehicleType: vehicleType,
        vehicleRegistrationNumber: vehicleRegistrationNumber,
        unionPermitNumber: unionPermitNumber,
      ),
    );
    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  Future<void> signOut() async {
    _currentUser = null;
    _authStateController.add(null);
  }
}
