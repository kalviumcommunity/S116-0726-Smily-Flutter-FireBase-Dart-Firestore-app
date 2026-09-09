import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

// Auth
import '../features/auth/screens/admin_login_screen.dart';
import '../features/auth/screens/driver_register_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/rider_register_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/auth/screens/splash_screen.dart';

// Rider
import '../features/passenger/screens/my_rides_screen.dart';
import '../features/passenger/screens/passenger_home_screen.dart';
import '../features/passenger/screens/ride_details_screen.dart';
import '../features/passenger/screens/ride_results_screen.dart';
import '../features/passenger/screens/rider_profile_screen.dart';
import '../features/passenger/screens/search_ride_screen.dart';

// Driver
import '../features/driver/screens/driver_dashboard_screen.dart';
import '../features/driver/screens/driver_my_rides_screen.dart';
import '../features/driver/screens/driver_profile_screen.dart';
import '../features/driver/screens/driver_ride_requests_screen.dart';

// Admin
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_users_screen.dart';

class AppRoutes {
  AppRoutes._();

  // ============================================================
  // AUTH
  // ============================================================

  static const String splash = '/';

  static const String roleSelection = '/role-selection';

  static const String login = '/login';

  static const String riderRegister = '/rider-register';

  static const String driverRegister = '/driver-register';

  static const String forgotPassword = '/forgot-password';

  static const String resetPassword = '/reset-password';

  static const String adminLogin = '/admin-login';

  // ============================================================
  // RIDER
  // ============================================================

  static const String passengerHome = '/passenger-home';

  static const String searchRide = '/search-ride';

  static const String rideResults = '/ride-results';

  static const String rideDetails = '/ride-details';

  static const String myRides = '/my-rides';

  static const String riderProfile = '/rider-profile';

  // ============================================================
  // DRIVER
  // ============================================================

  static const String driverDashboard = '/driver-dashboard';

  static const String driverRideRequests =
      '/driver-ride-requests';

  static const String driverMyRides =
      '/driver-my-rides';

  static const String driverProfile =
      '/driver-profile';

  // ============================================================
  // ADMIN
  // ============================================================

  static const String adminDashboard =
      '/admin-dashboard';

  static const String adminUsers =
      '/admin-users';

  // ============================================================
  // NAMED ROUTES
  // ============================================================

  static Map<String, WidgetBuilder> get routes {
    return {
      // ---------------- AUTH ----------------

      splash: (context) => const SplashScreen(),

      roleSelection: (context) =>
          const RoleSelectionScreen(),

      login: (context) => const LoginScreen(),

      riderRegister: (context) =>
          const RiderRegisterScreen(),

      driverRegister: (context) =>
          const DriverRegisterScreen(),

      forgotPassword: (context) =>
          const ForgotPasswordScreen(),

      resetPassword: (context) =>
          const ResetPasswordScreen(),

      adminLogin: (context) =>
          const AdminLoginScreen(),

      // ---------------- RIDER ----------------

      passengerHome: (context) =>
          const PassengerHomeScreen(),

      searchRide: (context) =>
          const SearchRideScreen(),

      rideResults: (context) =>
          const RideResultsScreen(),

      rideDetails: (context) =>
          const RideDetailsScreen(),

      myRides: (context) =>
          const MyRidesScreen(),

      riderProfile: (context) =>
          const RiderProfileScreen(),

      // ---------------- DRIVER ----------------

      driverDashboard: (context) =>
          const DriverDashboardScreen(),

      driverRideRequests: (context) =>
          const DriverRideRequestsScreen(),

      driverMyRides: (context) =>
          const DriverMyRidesScreen(),

      driverProfile: (context) =>
          const DriverProfileScreen(),

      // ---------------- ADMIN ----------------

      adminDashboard: (context) =>
          const AdminDashboardScreen(),

      adminUsers: (context) =>
          const AdminUsersScreen(),
    };
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String nextRoute;
  final String nextText;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.nextRoute,
    required this.nextText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppTheme.cardDark,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(nextRoute);
              },
              child: Text(nextText),
            ),
          ],
        ),
      ),
    );
  }
}