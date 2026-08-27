import 'package:flutter/material.dart';

import '../features/auth/screens/driver_register_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/rider_register_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/auth/screens/splash_screen.dart';
import '../routes/app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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

      case AppRoutes.passengerHome:
        return MaterialPageRoute(
          builder: (_) => const _ComingSoonScreen(
            title: 'Passenger Home',
          ),
        );

      case AppRoutes.driverDashboard:
        return MaterialPageRoute(
          builder: (_) => const _ComingSoonScreen(
            title: 'Driver Dashboard',
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}

class _ComingSoonScreen extends StatelessWidget {
  final String title;

  const _ComingSoonScreen({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}