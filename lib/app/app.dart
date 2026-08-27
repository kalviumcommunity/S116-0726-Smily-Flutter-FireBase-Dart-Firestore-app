import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';
import '../routes/app_router.dart';

class UnionRideApp extends StatelessWidget {
  const UnionRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UnionRide',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}