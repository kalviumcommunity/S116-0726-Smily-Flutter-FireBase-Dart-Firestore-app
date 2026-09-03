import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';
import '../features/auth/screens/role_selection_screen.dart';
import '../features/auth/screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';

  static const String roleSelection = '/role-selection';

  static const String login = '/login';

  static const String riderRegister = '/rider-register';

  static const String driverRegister = '/driver-register';

  static const String forgotPassword = '/forgot-password';

  static const String resetPassword = '/reset-password';

  static const String passengerHome = '/passenger-home';

  static const String searchRide = '/search-ride';

  static const String rideResults = '/ride-results';

  static const String rideDetails = '/ride-details';

  static const String myRides = '/my-rides';

  static const String riderProfile = '/rider-profile';

  static const String driverDashboard = '/driver-dashboard';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),

      roleSelection: (context) => const RoleSelectionScreen(),

      login: (context) => const LoginScreen(),

      forgotPassword: (context) => const ForgotPasswordScreen(),

      resetPassword: (context) => const ResetPasswordScreen(),
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
                Navigator.of(context).pushReplacementNamed(nextRoute);
              },
              child: Text(nextText),
            ),
          ],
        ),
      ),
    );
  }
}