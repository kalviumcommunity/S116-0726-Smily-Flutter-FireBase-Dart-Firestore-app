import 'package:flutter/material.dart';

// ---------------- AUTH ----------------
import '../features/auth/screens/admin_login_screen.dart';
import '../features/auth/screens/driver_register_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/rider_register_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/auth/screens/splash_screen.dart';

// ---------------- RIDER ----------------
import '../features/passenger/screens/my_rides_screen.dart';
import '../features/passenger/screens/passenger_home_screen.dart';
import '../features/passenger/screens/ride_details_screen.dart';
import '../features/passenger/screens/ride_results_screen.dart';
import '../features/passenger/screens/rider_profile_screen.dart';
import '../features/passenger/screens/search_ride_screen.dart';

// ---------------- DRIVER ----------------
import '../features/driver/screens/driver_dashboard_screen.dart';
import '../features/driver/screens/driver_my_rides_screen.dart';
import '../features/driver/screens/driver_profile_screen.dart';
import '../features/driver/screens/driver_ride_requests_screen.dart';

// ---------------- ADMIN ----------------
import '../features/admin/screens/admin_dashboard_screen.dart';
import '../features/admin/screens/admin_users_screen.dart';

// ---------------- ROUTES ----------------
import '../routes/app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ============================================================
      // AUTH
      // ============================================================

      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.roleSelection:
        return MaterialPageRoute(
          builder: (_) => const RoleSelectionScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.riderRegister:
        return MaterialPageRoute(
          builder: (_) => const RiderRegisterScreen(),
        );

      case AppRoutes.driverRegister:
        return MaterialPageRoute(
          builder: (_) => const DriverRegisterScreen(),
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case AppRoutes.adminLogin:
        return MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
        );

      // ============================================================
      // RIDER
      // ============================================================

      case AppRoutes.passengerHome:
        return MaterialPageRoute(
          builder: (_) => const PassengerHomeScreen(),
        );

      case AppRoutes.searchRide:
        return MaterialPageRoute(
          builder: (_) => const SearchRideScreen(),
        );

      case AppRoutes.rideResults:
        return MaterialPageRoute(
          builder: (_) => const RideResultsScreen(),
        );

      case AppRoutes.rideDetails:
        return MaterialPageRoute(
          builder: (_) => const RideDetailsScreen(),
        );

      case AppRoutes.myRides:
        return MaterialPageRoute(
          builder: (_) => const MyRidesScreen(),
        );

      case AppRoutes.riderProfile:
        return MaterialPageRoute(
          builder: (_) => const RiderProfileScreen(),
        );

      // ============================================================
      // DRIVER
      // ============================================================

      case AppRoutes.driverDashboard:
        return MaterialPageRoute(
          builder: (_) => const DriverDashboardScreen(),
        );

      case AppRoutes.driverRideRequests:
        return MaterialPageRoute(
          builder: (_) => const DriverRideRequestsScreen(),
        );

      case AppRoutes.driverMyRides:
        return MaterialPageRoute(
          builder: (_) => const DriverMyRidesScreen(),
        );

      case AppRoutes.driverProfile:
        return MaterialPageRoute(
          builder: (_) => const DriverProfileScreen(),
        );

      // ============================================================
      // ADMIN
      // ============================================================

      case AppRoutes.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
        );

      case AppRoutes.adminUsers:
        return MaterialPageRoute(
          builder: (_) => const AdminUsersScreen(),
        );

      // ============================================================
      // FALLBACK
      // ============================================================

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}