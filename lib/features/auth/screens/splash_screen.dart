import 'dart:async';
import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../core/constants/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _routeController;
  late AnimationController _loaderController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _contentFade;

  @override
  void initState() {
    super.initState();

    // Main logo entrance animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Animated route line
    _routeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // Loading spinner
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(
        0.0,
        0.65,
        curve: Curves.easeOut,
      ),
    );

    _logoScale = Tween<double>(
      begin: 0.82,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _contentFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(
        0.45,
        1.0,
        curve: Curves.easeOut,
      ),
    );

    _logoController.forward();

    Timer(const Duration(milliseconds: 2800), () async {
      if (!mounted) return;

      final authService = AuthService();
      final currentUser = authService.currentUser;

      if (currentUser != null) {
        final profile = await authService.getUserProfile(currentUser.uid);
        if (!mounted) return;
        if (profile != null && profile.isActive) {
          if (profile.role == AppConstants.roleDriver) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.driverDashboard,
            );
            return;
          } else {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.passengerHome,
            );
            return;
          }
        }
      }

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _routeController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle background glow
            Positioned(
              top: 80,
              left: -100,
              right: -100,
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.035),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Faint map background
            const Positioned.fill(
              child: _MapBackground(),
            ),

            // Main content
            Center(
              child: FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // UnionRide logo mark
                      const _UnionRideLogo(),

                      const SizedBox(height: 24),

                      // App name
                      Text(
                        'UnionRide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.5,
                        ),
                      ),

                      const SizedBox(height: 14),

                      FadeTransition(
                        opacity: _contentFade,
                        child: Text(
                          'MOVE TOGETHER.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Animated route section
            Positioned(
              left: 0,
              right: 0,
              bottom: 115,
              child: AnimatedBuilder(
                animation: _routeController,
                builder: (context, child) {
                  return SizedBox(
                    height: 230,
                    child: CustomPaint(
                      painter: _RoutePainter(
                        progress: _routeController.value,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Loading section
            Positioned(
              bottom: 42,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _contentFade,
                child: Column(
                  children: [
                    RotationTransition(
                      turns: _loaderController,
                      child: SizedBox(
                        height: 28,
                        width: 28,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.85),
                          ),
                          backgroundColor:
                              Colors.white.withOpacity(0.08),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'LOADING',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =====================================================
// UNIONRIDE LOGO MARK
// =====================================================

class _UnionRideLogo extends StatelessWidget {
  const _UnionRideLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      height: 72,
      child: CustomPaint(
        painter: _LogoPainter(),
      ),
    );
  }
}


// =====================================================
// LOGO PAINTER
// =====================================================

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF4F4F4)
      ..style = PaintingStyle.fill;

    // Left circle
    canvas.drawCircle(
      Offset(size.width * 0.18, size.height * 0.70),
      size.width * 0.13,
      paint,
    );

    // Main connected rounded shape
    final path = Path();

    path.moveTo(size.width * 0.30, size.height * 0.20);

    path.quadraticBezierTo(
      size.width * 0.42,
      size.height * 0.05,
      size.width * 0.55,
      size.height * 0.25,
    );

    path.lineTo(size.width * 0.68, size.height * 0.52);

    path.quadraticBezierTo(
      size.width * 0.76,
      size.height * 0.65,
      size.width * 0.88,
      size.height * 0.58,
    );

    path.quadraticBezierTo(
      size.width * 0.98,
      size.height * 0.53,
      size.width * 0.98,
      size.height * 0.70,
    );

    path.quadraticBezierTo(
      size.width * 0.98,
      size.height * 0.92,
      size.width * 0.78,
      size.height * 0.92,
    );

    path.quadraticBezierTo(
      size.width * 0.68,
      size.height * 0.92,
      size.width * 0.60,
      size.height * 0.70,
    );

    path.lineTo(size.width * 0.48, size.height * 0.48);

    path.quadraticBezierTo(
      size.width * 0.43,
      size.height * 0.38,
      size.width * 0.30,
      size.height * 0.38,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// =====================================================
// ROUTE ANIMATION
// =====================================================

class _RoutePainter extends CustomPainter {
  final double progress;

  _RoutePainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final routePaint = Paint()
      ..color = Colors.white.withOpacity(0.82)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.12, size.height * 0.85)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.72,
        size.width * 0.28,
        size.height * 0.25,
        size.width * 0.52,
        size.height * 0.48,
      )
      ..cubicTo(
        size.width * 0.70,
        size.height * 0.70,
        size.width * 0.75,
        size.height * 0.30,
        size.width * 0.88,
        size.height * 0.18,
      );

    final metric = path.computeMetrics().first;

    final animatedPath = metric.extractPath(
      0,
      metric.length * progress,
    );

    // Soft glow
    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(animatedPath, glowPaint);
    canvas.drawPath(animatedPath, routePaint);

    // Start point
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.85),
      7,
      Paint()..color = Colors.white,
    );

    // Destination
    final destination =
        Offset(size.width * 0.88, size.height * 0.18);

    canvas.drawCircle(
      destination,
      17,
      Paint()
        ..color = Colors.white.withOpacity(0.08),
    );

    canvas.drawCircle(
      destination,
      7,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant _RoutePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


// =====================================================
// SUBTLE MAP BACKGROUND
// =====================================================

class _MapBackground extends StatelessWidget {
  const _MapBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MapPainter(),
    );
  }
}


class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..strokeWidth = 1;

    final startY = size.height * 0.56;

    for (double y = startY; y < size.height; y += 42) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + 28),
        paint,
      );
    }

    for (double x = -size.width; x < size.width * 2; x += 65) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.width * 0.45, startY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}