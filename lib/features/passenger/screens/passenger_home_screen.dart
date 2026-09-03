import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  int _selectedIndex = 0;

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature will be available soon.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      body: SafeArea(
        bottom: false,
        child: _buildHome(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ─────────────────────────────────────────────
  // HOME
  // ─────────────────────────────────────────────

  Widget _buildHome() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildTopBar(),
                const SizedBox(height: 26),
                _buildGreeting(),
                const SizedBox(height: 20),
                _buildMapCard(),
                const SizedBox(height: 18),
                _buildSearchCard(),
                const SizedBox(height: 22),
                _buildSectionHeader(
                  title: 'Quick actions',
                  action: null,
                ),
                const SizedBox(height: 12),
                _buildQuickActions(),
                const SizedBox(height: 28),
                _buildSectionHeader(
                  title: 'Upcoming ride',
                  action: 'View all',
                  onAction: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.myRides,
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildUpcomingRide(),
                const SizedBox(height: 28),
                _buildSectionHeader(
                  title: 'Recent ride',
                  action: 'See history',
                  onAction: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.myRides,
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildRecentRide(),
                const SizedBox(height: 28),
                _buildAnnouncement(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // TOP BAR
  // ─────────────────────────────────────────────

  Widget _buildTopBar() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF111214),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF242528),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Spacer(),
        _buildIconButton(
          icon: Icons.notifications_none_rounded,
          onTap: () => _showComingSoon('Notifications'),
          showDot: true,
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool showDot = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF111214),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF242528),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),
          ),
          if (showDot)
            Positioned(
              right: 10,
              top: 9,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // GREETING
  // ─────────────────────────────────────────────

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good afternoon, Khushal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Where are you heading today?',
          style: TextStyle(
            color: Color(0xFF8C8D91),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // MAP
  // ─────────────────────────────────────────────

  Widget _buildMapCard() {
    return Container(
      height: 205,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF101113),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF222326),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/map.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return CustomPaint(
                  painter: _MapPainter(),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.18),
            ),
          ),

          const Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 52,
                  height: 52,
                ),
                _LocationMarker(),
              ],
            ),
          ),

          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xE6090A0B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.my_location_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Current location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 14,
            bottom: 14,
            child: GestureDetector(
              onTap: () => _showComingSoon('Live location'),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xE6090A0B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SEARCH CARD
  // ─────────────────────────────────────────────

  Widget _buildSearchCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF111214),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF252629),
        ),
      ),
      child: Column(
        children: [
          _buildLocationRow(
            icon: Icons.radio_button_checked_rounded,
            iconColor: const Color(0xFFB7B7BA),
            title: 'From',
            value: 'Current location',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.searchRide,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Container(
              height: 20,
              width: 1,
              color: const Color(0xFF35363A),
            ),
          ),
          _buildLocationRow(
            icon: Icons.location_on_outlined,
            iconColor: Colors.white,
            title: 'To',
            value: 'Where do you want to go?',
            isDestination: true,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.searchRide,
              );
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.searchRide,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Find a Ride',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    bool isDestination = false,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: Colors.white.withValues(alpha: 0.04),
        highlightColor: Colors.white.withValues(alpha: 0.02),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  color: iconColor,
                  size: isDestination ? 21 : 15,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF77787C),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: TextStyle(
                        color: isDestination
                            ? const Color(0xFFB9BABD)
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isDestination)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF66676A),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // QUICK ACTIONS
  // ─────────────────────────────────────────────

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickAction(
            icon: Icons.group_outlined,
            title: 'Join a Ride',
            subtitle: 'Find a ride',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.searchRide,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickAction(
            icon: Icons.add_road_rounded,
            title: 'Offer a Ride',
            subtitle: 'Share your route',
            onTap: () => _showComingSoon('Offer a Ride'),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: Colors.white.withValues(alpha: 0.05),
        highlightColor: Colors.white.withValues(alpha: 0.03),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0E10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF202124),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF18191B),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF77787C),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // SECTION HEADER
  // ─────────────────────────────────────────────

  Widget _buildSectionHeader({
    required String title,
    String? action,
    VoidCallback? onAction,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              action,
              style: const TextStyle(
                color: Color(0xFF96979B),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // UPCOMING RIDE
  // ─────────────────────────────────────────────

  Widget _buildUpcomingRide() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.myRides,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: const Color(0xFF111214),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF242528),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1D20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'TOMORROW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  '₹120',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.radio_button_checked_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    Container(
                      height: 27,
                      width: 1,
                      color: const Color(0xFF38393C),
                    ),
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Punjabi Bagh',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Connaught Place',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '09:30 AM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 19),
                    Text(
                      '10:15 AM',
                      style: TextStyle(
                        color: Color(0xFF88898D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 17),
            Container(
              height: 1,
              color: const Color(0xFF242528),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF202124),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Aman Sharma  •  4.9 ★',
                    style: TextStyle(
                      color: Color(0xFFB7B8BB),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF696A6E),
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // RECENT RIDE
  // ─────────────────────────────────────────────

  Widget _buildRecentRide() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.myRides,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0E10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF202124),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                color: const Color(0xFF18191B),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.route_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rajouri Garden → Dwarka',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Yesterday  •  8:42 AM',
                    style: TextStyle(
                      color: Color(0xFF77787C),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              '₹95',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // ANNOUNCEMENT
  // ─────────────────────────────────────────────

  Widget _buildAnnouncement() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF111214),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF242528),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ride together, travel smarter.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Find trusted rides from people travelling your way.',
                  style: TextStyle(
                    color: Color(0xFF7E7F83),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BOTTOM NAVIGATION
  // ─────────────────────────────────────────────

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF08090A),
        border: Border(
          top: BorderSide(
            color: Color(0xFF202124),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 9, 18, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.directions_car_outlined,
                label: 'Rides',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          setState(() {
            _selectedIndex = 0;
          });
        } else if (index == 1) {
          Navigator.pushNamed(
            context,
            AppRoutes.myRides,
          );
        } else if (index == 2) {
          Navigator.pushNamed(
            context,
            AppRoutes.riderProfile,
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF68696D),
              size: 22,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF68696D),
                fontSize: 10.5,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOCATION MARKER
// ─────────────────────────────────────────────

class _LocationMarker extends StatelessWidget {
  const _LocationMarker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF030405),
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// FALLBACK MAP PAINTER
// ─────────────────────────────────────────────

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..color = const Color(0xFF17191B);

    canvas.drawRect(
      Offset.zero & size,
      background,
    );

    final roadPaint = Paint()
      ..color = const Color(0xFF2B2D30)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final thinRoadPaint = Paint()
      ..color = const Color(0xFF242629)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path1 = Path()
      ..moveTo(0, size.height * 0.75)
      ..quadraticBezierTo(
        size.width * 0.30,
        size.height * 0.50,
        size.width * 0.55,
        size.height * 0.68,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.84,
        size.width,
        size.height * 0.30,
      );

    final path2 = Path()
      ..moveTo(size.width * 0.10, 0)
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.35,
        size.width * 0.70,
        size.height * 0.20,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.12,
        size.width,
        size.height * 0.05,
      );

    final path3 = Path()
      ..moveTo(size.width * 0.20, size.height)
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.72,
        size.width * 0.78,
        size.height * 0.80,
      );

    canvas.drawPath(path1, roadPaint);
    canvas.drawPath(path2, thinRoadPaint);
    canvas.drawPath(path3, thinRoadPaint);

    for (var i = 1; i < 5; i++) {
      final y = size.height * i / 5;

      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y + 25),
        thinRoadPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}