import 'package:flutter/material.dart';
import '../features/auth/screens/register_screen.dart';
import '../core/theme/app_theme.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String passengerHome = '/passenger-home';
  static const String driverDashboard = '/driver-dashboard';

  static Map<String, WidgetBuilder> get routes {
    return {
      register: (context) => const RegisterScreen(),
      login: (context) => const PlaceholderScreen(title: 'Log In Screen', nextRoute: register, nextText: 'Go to Registration'),
      passengerHome: (context) => const PlaceholderScreen(title: 'Passenger Home', nextRoute: register, nextText: 'Back to Register'),
      driverDashboard: (context) => const PlaceholderScreen(title: 'Driver Dashboard', nextRoute: register, nextText: 'Back to Register'),
    };
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  final String nextRoute;
  final String nextText;

  const PlaceholderScreen({
    Key? key,
    required this.title,
    required this.nextRoute,
    required this.nextText,
  }) : super(key: key);

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
