class AppConstants {
  // App Details
  static const String appName = 'UnionRide';
  static const String appTagline = 'Automated Auto & Cab On-Demand Dispatch';

  // User Roles
  static const String rolePassenger = 'passenger';
  static const String roleDriver = 'driver';
  static const String roleAdmin = 'admin';

  // Vehicle Types
  static const String vehicleAuto = 'auto';
  static const String vehicleCab = 'cab';

  // Firestore Collections
  static const String collectionUsers = 'users';
  static const String collectionDrivers = 'drivers';
  static const String collectionRides = 'rides';
  static const String collectionZones = 'zones';

  // Storage Paths
  static String userAvatarPath(String uid) => 'users/$uid/avatar.jpg';
  static String driverLicensePath(String uid) => 'drivers/$uid/license.jpg';
  static String driverRcPath(String uid) => 'drivers/$uid/rc_permit.pdf';
}
