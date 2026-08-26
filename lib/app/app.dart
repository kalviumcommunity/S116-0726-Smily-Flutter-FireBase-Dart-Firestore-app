import 'package:flutter/material.dart';
import 'app_router.dart';
import 'app_theme.dart';

class UnionRideApp extends StatelessWidget {
  const UnionRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnionRide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}