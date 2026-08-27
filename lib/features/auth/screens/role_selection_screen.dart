import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 42),

            // ================= LOGO =================
            Image.asset(
              'assets/images/logo.png',
              width: 170,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'UnionRide',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 58),

            // ================= TITLE =================
            const Text(
              'Choose your role',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.8,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Select how you’d like to use UnionRide.',
              style: TextStyle(
                color: Color(0xFF9A9A9A),
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 42),

            // ================= RIDER =================
            _RoleCard(
              title: 'Rider',
              description: 'Find and join rides\ngoing your way.',
              icon: Icons.person_outline_rounded,
              isSelected: selectedRole == 'Rider',
              onTap: () {
                setState(() {
                  selectedRole = 'Rider';
                });
              },
            ),

            const SizedBox(height: 18),

            // ================= DRIVER =================
            _RoleCard(
              title: 'Driver',
              description: 'Offer rides and help\nothers travel.',
              icon: Icons.directions_car_rounded,
              isSelected: selectedRole == 'Driver',
              onTap: () {
                setState(() {
                  selectedRole = 'Driver';
                });
              },
            ),

            const Spacer(),

            // ================= CONTINUE =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 62,
                child: ElevatedButton(
                  onPressed: selectedRole == null
                      ? null
                      : () {
                          Navigator.pushNamed(
                            context,
                            selectedRole == 'Driver'
                                ? AppRoutes.driverRegister
                                : AppRoutes.riderRegister,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF242424),
                    foregroundColor: Colors.black,
                    disabledForegroundColor: const Color(0xFF777777),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ================= LOGIN =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.login,
                    );
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ROLE CARD
// =====================================================

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          height: 160,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF101214)
                : const Color(0xFF070809),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF3A3D40),
              width: isSelected ? 1.5 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.08),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              // ICON CIRCLE
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF101214),
                  border: Border.all(
                    color: const Color(0xFF292C2F),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.08),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 42,
                ),
              ),

              const SizedBox(width: 22),

              // TEXT
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // ARROW
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF25282B),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}