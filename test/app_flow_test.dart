import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_ride/routes/app_routes.dart';
import 'package:union_ride/routes/app_router.dart';
import 'package:union_ride/features/auth/screens/role_selection_screen.dart';
import 'package:union_ride/features/auth/screens/login_screen.dart';
import 'package:union_ride/features/auth/screens/admin_login_screen.dart';
import 'package:union_ride/features/auth/screens/reset_password_screen.dart';
import 'package:union_ride/features/passenger/screens/passenger_home_screen.dart';
import 'package:union_ride/features/passenger/screens/search_ride_screen.dart';
import 'package:union_ride/features/passenger/screens/ride_results_screen.dart';
import 'package:union_ride/features/passenger/screens/ride_details_screen.dart';
import 'package:union_ride/features/passenger/screens/my_rides_screen.dart';
import 'package:union_ride/features/passenger/screens/rider_profile_screen.dart';
import 'package:union_ride/features/driver/screens/driver_dashboard_screen.dart';
import 'package:union_ride/features/driver/screens/driver_ride_requests_screen.dart';
import 'package:union_ride/features/driver/screens/driver_my_rides_screen.dart';
import 'package:union_ride/features/driver/screens/driver_profile_screen.dart';
import 'package:union_ride/features/admin/screens/admin_dashboard_screen.dart';
import 'package:union_ride/features/admin/screens/admin_users_screen.dart';

void main() {
  group('Route Resolution Tests', () {
    test('All route constants are defined and unique', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.roleSelection,
        AppRoutes.login,
        AppRoutes.riderRegister,
        AppRoutes.driverRegister,
        AppRoutes.forgotPassword,
        AppRoutes.resetPassword,
        AppRoutes.adminLogin,
        AppRoutes.passengerHome,
        AppRoutes.searchRide,
        AppRoutes.rideResults,
        AppRoutes.rideDetails,
        AppRoutes.myRides,
        AppRoutes.riderProfile,
        AppRoutes.driverDashboard,
        AppRoutes.driverRideRequests,
        AppRoutes.driverMyRides,
        AppRoutes.driverProfile,
        AppRoutes.adminDashboard,
        AppRoutes.adminUsers,
      ];

      expect(routes.toSet().length, routes.length);
    });

    test('AppRouter generates valid routes for all AppRoutes', () {
      final routes = [
        AppRoutes.splash,
        AppRoutes.roleSelection,
        AppRoutes.login,
        AppRoutes.riderRegister,
        AppRoutes.driverRegister,
        AppRoutes.forgotPassword,
        AppRoutes.resetPassword,
        AppRoutes.adminLogin,
        AppRoutes.passengerHome,
        AppRoutes.searchRide,
        AppRoutes.rideResults,
        AppRoutes.rideDetails,
        AppRoutes.myRides,
        AppRoutes.riderProfile,
        AppRoutes.driverDashboard,
        AppRoutes.driverRideRequests,
        AppRoutes.driverMyRides,
        AppRoutes.driverProfile,
        AppRoutes.adminDashboard,
        AppRoutes.adminUsers,
      ];

      for (final routeName in routes) {
        final route = AppRouter.generateRoute(RouteSettings(name: routeName));
        expect(route, isA<MaterialPageRoute>());
      }
    });

    test('AppRoutes.routes map has all defined routes', () {
      final map = AppRoutes.routes;
      expect(map.containsKey(AppRoutes.splash), isTrue);
      expect(map.containsKey(AppRoutes.roleSelection), isTrue);
      expect(map.containsKey(AppRoutes.login), isTrue);
      expect(map.containsKey(AppRoutes.adminLogin), isTrue);
      expect(map.containsKey(AppRoutes.riderRegister), isTrue);
      expect(map.containsKey(AppRoutes.driverRegister), isTrue);
      expect(map.containsKey(AppRoutes.forgotPassword), isTrue);
      expect(map.containsKey(AppRoutes.resetPassword), isTrue);
      expect(map.containsKey(AppRoutes.passengerHome), isTrue);
      expect(map.containsKey(AppRoutes.searchRide), isTrue);
      expect(map.containsKey(AppRoutes.rideResults), isTrue);
      expect(map.containsKey(AppRoutes.rideDetails), isTrue);
      expect(map.containsKey(AppRoutes.myRides), isTrue);
      expect(map.containsKey(AppRoutes.riderProfile), isTrue);
      expect(map.containsKey(AppRoutes.driverDashboard), isTrue);
      expect(map.containsKey(AppRoutes.driverRideRequests), isTrue);
      expect(map.containsKey(AppRoutes.driverMyRides), isTrue);
      expect(map.containsKey(AppRoutes.driverProfile), isTrue);
      expect(map.containsKey(AppRoutes.adminDashboard), isTrue);
      expect(map.containsKey(AppRoutes.adminUsers), isTrue);
    });
  });

  group('Auth Flow Tests', () {
    testWidgets('RoleSelectionScreen shows Rider and Driver and not Admin',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: RoleSelectionScreen()),
      );

      expect(find.text('Choose your role'), findsOneWidget);
      expect(find.text('Rider'), findsOneWidget);
      expect(find.text('Driver'), findsOneWidget);
      // Admin MUST NOT appear as public role selection
      expect(find.text('Admin'), findsNothing);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.text('Log in'), findsOneWidget);
    });

    testWidgets('LoginScreen shows Admin Portal entry point',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LoginScreen()),
      );

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Admin Portal'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('AdminLoginScreen renders credentials and dashboard sign-in button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: AdminLoginScreen()),
      );

      expect(find.text('Admin Sign In'), findsOneWidget);
      expect(find.text('ADMIN PORTAL'), findsOneWidget);
      expect(find.text('Sign In to Dashboard'), findsOneWidget);
      expect(find.text('Back to User Login'), findsOneWidget);
    });

    testWidgets('ResetPasswordScreen validates and has reset action',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ResetPasswordScreen()),
      );

      expect(find.text('Reset password'), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
    });
  });

  group('Rider Flow Widget Tests', () {
    testWidgets('PassengerHomeScreen renders header and navigation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: PassengerHomeScreen()),
      );

      expect(find.text('Good afternoon, Khushal'), findsOneWidget);
      expect(find.text('Find a Ride'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Rides'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('SearchRideScreen renders form and search button',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SearchRideScreen()),
      );

      expect(find.text('Where are you going?'), findsOneWidget);
      expect(find.text('Search Rides'), findsOneWidget);
    });

    testWidgets('RideResultsScreen renders ride list and filter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: RideResultsScreen()),
      );

      expect(find.text('Available Rides'), findsOneWidget);
      expect(find.text('4 rides available'), findsOneWidget);
      expect(find.text('Aman Sharma'), findsOneWidget);
    });

    testWidgets('RideDetailsScreen renders details and booking confirmation',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: RideDetailsScreen()),
      );

      expect(find.text('Ride Details'), findsOneWidget);
      expect(find.text('Book This Ride'), findsOneWidget);
      expect(find.text('Aman Sharma'), findsOneWidget);
    });

    testWidgets('MyRidesScreen renders upcoming and past rides',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: MyRidesScreen()),
      );

      expect(find.text('My Rides'), findsOneWidget);
      expect(find.text('Upcoming'), findsNWidgets(2));
      expect(find.text('Past rides'), findsOneWidget);
    });

    testWidgets('RiderProfileScreen renders profile info and logout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: RiderProfileScreen()),
      );

      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Khushal Rajput'), findsNWidgets(2));

      await tester.scrollUntilVisible(
        find.text('Log out'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Log out'), findsOneWidget);
    });
  });

  group('Driver Flow Widget Tests', () {
    testWidgets('DriverDashboardScreen renders online switch and ride request',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DriverDashboardScreen()),
      );

      expect(find.text('Good morning, Khushal'), findsOneWidget);
      expect(find.text("You're Offline"), findsOneWidget);
      expect(find.text('New Ride Request'), findsOneWidget);
      expect(find.text('Accept'), findsOneWidget);
      expect(find.text('Reject'), findsOneWidget);
    });

    testWidgets('DriverRideRequestsScreen renders pending requests',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DriverRideRequestsScreen()),
      );

      expect(find.text('Ride Requests'), findsOneWidget);
      expect(find.text('NEW REQUESTS'), findsOneWidget);
      expect(find.text('Aman Sharma'), findsOneWidget);
    });

    testWidgets('DriverMyRidesScreen renders tabs and cards',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DriverMyRidesScreen()),
      );

      expect(find.text('My Rides'), findsOneWidget);
      expect(find.text('Upcoming'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('DriverProfileScreen renders driver details and logout',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DriverProfileScreen()),
      );

      expect(find.text('Profile'), findsNWidgets(2));
      expect(find.text('VEHICLE INFORMATION'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });
  });

  group('Admin Flow Widget Tests', () {
    testWidgets('AdminDashboardScreen renders live status, metrics, and logout action',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: AdminDashboardScreen()),
      );

      expect(find.text('Admin Dashboard'), findsOneWidget);
      expect(find.text('System Status'), findsOneWidget);
      expect(find.text('Active Drivers'), findsOneWidget);
      expect(find.text('Active Rides'), findsOneWidget);
      expect(find.byIcon(Icons.logout_rounded), findsOneWidget);
    });

    testWidgets('AdminUsersScreen renders Riders and Drivers with search',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AdminUsersScreen())),
      );

      expect(find.text('Users'), findsOneWidget);
      expect(find.text('Riders'), findsOneWidget);
      expect(find.text('Drivers'), findsOneWidget);
      expect(find.text('Aman Sharma'), findsOneWidget);
    });
  });
}
