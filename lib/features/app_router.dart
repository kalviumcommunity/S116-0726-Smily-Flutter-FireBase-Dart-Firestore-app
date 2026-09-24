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
          settings: settings,
        );

      case AppRoutes.roleSelection:
        return MaterialPageRoute(
          builder: (_) => const RoleSelectionScreen(),
          settings: settings,
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.riderRegister:
        return MaterialPageRoute(
          builder: (_) => const RiderRegisterScreen(),
          settings: settings,
        );

      case AppRoutes.driverRegister:
        return MaterialPageRoute(
          builder: (_) => const DriverRegisterScreen(),
          settings: settings,
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case AppRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
          settings: settings,
        );

      case AppRoutes.adminLogin:
        return MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
          settings: settings,
        );

      // ============================================================
      // RIDER
      // ============================================================

      case AppRoutes.passengerHome:
        return MaterialPageRoute(
          builder: (_) => const PassengerHomeScreen(),
          settings: settings,
        );

      case AppRoutes.searchRide:
        return MaterialPageRoute(
          builder: (_) => const SearchRideScreen(),
          settings: settings,
        );

      case AppRoutes.rideResults:
        return MaterialPageRoute(
          builder: (_) => const RideResultsScreen(),
          settings: settings,
        );

      case AppRoutes.rideDetails:
        return MaterialPageRoute(
          builder: (_) => const RideDetailsScreen(),
          settings: settings,
        );

      case AppRoutes.myRides:
        return MaterialPageRoute(
          builder: (_) => const MyRidesScreen(),
          settings: settings,
        );

      case AppRoutes.riderProfile:
        return MaterialPageRoute(
          builder: (_) => const RiderProfileScreen(),
          settings: settings,
        );

      // ============================================================
      // DRIVER
      // ============================================================

      case AppRoutes.driverDashboard:
        return MaterialPageRoute(
          builder: (_) => const DriverDashboardScreen(),
          settings: settings,
        );

      case AppRoutes.driverRideRequests:
        return MaterialPageRoute(
          builder: (_) => const DriverRideRequestsScreen(),
          settings: settings,
        );

      case AppRoutes.driverMyRides:
        return MaterialPageRoute(
          builder: (_) => const DriverMyRidesScreen(),
          settings: settings,
        );

      case AppRoutes.driverProfile:
        return MaterialPageRoute(
          builder: (_) => const DriverProfileScreen(),
          settings: settings,
        );

      // ============================================================
      // ADMIN
      // ============================================================

      case AppRoutes.adminDashboard:
        return MaterialPageRoute(
          builder: (_) => const AdminDashboardScreen(),
          settings: settings,
        );

      case AppRoutes.adminUsers:
        return MaterialPageRoute(
          builder: (_) => const AdminUsersScreen(),
          settings: settings,
        );

      // ============================================================
      // FALLBACK
      // ============================================================

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
