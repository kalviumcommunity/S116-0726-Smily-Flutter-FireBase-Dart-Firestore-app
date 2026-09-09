import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class DriverMyRidesScreen extends StatefulWidget {
  const DriverMyRidesScreen({super.key});

  @override
  State<DriverMyRidesScreen> createState() => _DriverMyRidesScreenState();
}

class _DriverMyRidesScreenState extends State<DriverMyRidesScreen> {
  int _selectedTab = 0;

  static const Color _background = Color(0xFF030405);
  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

  static const List<String> _tabs = [
    'Upcoming',
    'Active',
    'Completed',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildTabs(),
                    const SizedBox(height: 22),
                    _buildContent(),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Rides',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Your accepted and completed rides',
          style: TextStyle(
            color: _muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _border,
        ),
      ),
      child: Row(
        children: List.generate(
          _tabs.length,
          (index) {
            final bool selected = _selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = index;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? _cardLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: selected ? Colors.white : _muted,
                      fontSize: 11.5,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedTab) {
      case 0:
        return _buildUpcoming();
      case 1:
        return _buildActive();
      case 2:
        return _buildCompleted();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildUpcoming() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('UPCOMING'),
        const SizedBox(height: 11),
        _buildRideCard(
          passenger: 'Aman Sharma',
          route: 'Pune → Mumbai',
          pickup: 'Pune Station',
          destination: 'Mumbai Central',
          dateTime: 'Tomorrow · 9:30 AM',
          fare: '₹700',
          status: 'Accepted',
          statusIcon: Icons.check_circle_outline_rounded,
        ),
        const SizedBox(height: 12),
        _buildRideCard(
          passenger: 'Rahul Mehta',
          route: 'Mumbai → Pune',
          pickup: 'Andheri',
          destination: 'Pune Station',
          dateTime: 'Friday · 6:00 PM',
          fare: '₹1,050',
          status: 'Accepted',
          statusIcon: Icons.check_circle_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildActive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('ACTIVE RIDE'),
        const SizedBox(height: 11),
        _buildRideCard(
          passenger: 'Vikram Singh',
          route: 'Pune → Lonavala',
          pickup: 'Hinjewadi',
          destination: 'Lonavala Market',
          dateTime: 'Today · 10:00 AM',
          fare: '₹500',
          status: 'Ride in progress',
          statusIcon: Icons.radio_button_checked_rounded,
          active: true,
          actionText: 'End Ride',
        ),
      ],
    );
  }

  Widget _buildCompleted() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('COMPLETED RIDES'),
        const SizedBox(height: 11),
        _buildRideCard(
          passenger: 'Vikram Singh',
          route: 'Mumbai → Pune',
          pickup: 'Mumbai Central',
          destination: 'Pune Station',
          dateTime: 'Yesterday · 6:00 PM',
          fare: '₹1,050',
          status: 'Completed',
          statusIcon: Icons.check_circle_outline_rounded,
        ),
        const SizedBox(height: 12),
        _buildRideCard(
          passenger: 'Aman Sharma',
          route: 'Pune → Nashik',
          pickup: 'Pune Station',
          destination: 'Nashik Road',
          dateTime: 'Monday · 8:30 AM',
          fare: '₹800',
          status: 'Completed',
          statusIcon: Icons.check_circle_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _muted,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildRideCard({
    required String passenger,
    required String route,
    required String pickup,
    required String destination,
    required String dateTime,
    required String fare,
    required String status,
    required IconData statusIcon,
    bool active = false,
    String? actionText,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? const Color(0xFF36373A) : _border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _cardLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      passenger,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      route,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                fare,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            color: Color(0xFF202124),
          ),
          const SizedBox(height: 14),
          _buildLocationRow(
            icon: Icons.radio_button_checked_rounded,
            label: 'PICKUP',
            location: pickup,
          ),
          const SizedBox(height: 11),
          _buildLocationRow(
            icon: Icons.location_on_outlined,
            label: 'DESTINATION',
            location: destination,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(
                Icons.schedule_rounded,
                color: Color(0xFF85868A),
                size: 16,
              ),
              const SizedBox(width: 7),
              Text(
                dateTime,
                style: const TextStyle(
                  color: _secondary,
                  fontSize: 10.5,
                ),
              ),
              const Spacer(),
              Icon(
                statusIcon,
                color: active ? Colors.white : const Color(0xFF85868A),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF85868A),
                  fontSize: 10.5,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
          if (actionText != null) ...[
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: _handleRideAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  actionText,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required String label,
    required String location,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF85868A),
          size: 17,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                location,
                style: const TextStyle(
                  color: _secondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
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
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.driverDashboard,
                  );
                },
              ),
              _buildNavItem(
                icon: Icons.directions_car_rounded,
                label: 'Rides',
                selected: true,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.driverProfile,
                  );
                },
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
    required VoidCallback onTap,
    bool selected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xFF68696D),
              size: 22,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF68696D),
                fontSize: 10.5,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRideAction() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ride ended'),
        duration: Duration(seconds: 2),
      ),
    );

    setState(() {
      _selectedTab = 2;
    });
  }
}