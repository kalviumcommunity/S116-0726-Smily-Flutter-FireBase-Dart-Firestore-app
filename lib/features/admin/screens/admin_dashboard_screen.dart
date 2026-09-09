import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import 'admin_users_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  static const Color _background = Color(0xFF030405);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  _DashboardContent(),
                  AdminUsersScreen(),
                ],
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
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
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                selected: _selectedIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              _buildNavItem(
                icon: Icons.people_outline_rounded,
                label: 'Users',
                selected: _selectedIndex == 1,
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
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
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 110,
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected
                  ? Colors.white
                  : const Color(0xFF68696D),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(0xFF68696D),
                fontSize: 10.5,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 22),
          _buildLiveStatus(),
          const SizedBox(height: 22),
          _buildSectionTitle('OVERVIEW'),
          const SizedBox(height: 10),
          _buildStatsGrid(),
          const SizedBox(height: 22),
          _buildSectionTitle('RIDE ACTIVITY'),
          const SizedBox(height: 10),
          _buildRideActivity(),
          const SizedBox(height: 22),
          _buildSectionTitle('RECENT ACTIVITY'),
          const SizedBox(height: 10),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'UnionRide operations overview',
                style: TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _cardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _border),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showAdminLogoutDialog(context),
            icon: const Icon(
              Icons.logout_rounded,
              color: Color(0xFFB0B1B4),
              size: 18,
            ),
            tooltip: 'Log out',
          ),
        ),
      ],
    );
  }

  void _showAdminLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: _border),
          ),
          title: const Text(
            'Admin Logout',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to end your admin session?',
            style: TextStyle(
              color: _secondary,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: _muted),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLiveStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _cardLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.circle,
              color: Colors.white,
              size: 13,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'All services operational',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: _cardLight,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Text(
              'ONLINE',
              style: TextStyle(
                color: Color(0xFFB8B9BC),
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.55,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _StatCard(
          icon: Icons.people_outline_rounded,
          title: 'Active Drivers',
          value: '24',
        ),
        _StatCard(
          icon: Icons.directions_car_outlined,
          title: 'Active Rides',
          value: '12',
        ),
        _StatCard(
          icon: Icons.pending_actions_rounded,
          title: 'Pending Rides',
          value: '7',
        ),
        _StatCard(
          icon: Icons.event_available_outlined,
          title: "Today's Rides",
          value: '86',
        ),
      ],
    );
  }

  Widget _buildRideActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _border,
        ),
      ),
      child: const Column(
        children: [
          _ActivityRow(
            icon: Icons.directions_car_outlined,
            title: 'Active drivers',
            value: '24',
          ),
          Divider(
            height: 22,
            color: Color(0xFF202124),
          ),
          _ActivityRow(
            icon: Icons.route_outlined,
            title: 'Rides completed today',
            value: '74',
          ),
          Divider(
            height: 22,
            color: Color(0xFF202124),
          ),
          _ActivityRow(
            icon: Icons.currency_rupee_rounded,
            title: "Today's earnings",
            value: '₹48,600',
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _border,
        ),
      ),
      child: const Column(
        children: [
          _RecentActivityRow(
            icon: Icons.check_circle_outline_rounded,
            title: 'Ride completed',
            subtitle: 'Pune → Mumbai',
            time: '2 min ago',
          ),
          Divider(
            height: 1,
            color: Color(0xFF202124),
          ),
          _RecentActivityRow(
            icon: Icons.person_add_alt_1_outlined,
            title: 'New driver registered',
            subtitle: 'Driver verification pending',
            time: '12 min ago',
          ),
          Divider(
            height: 1,
            color: Color(0xFF202124),
          ),
          _RecentActivityRow(
            icon: Icons.flag_outlined,
            title: 'New ride request',
            subtitle: 'Mumbai → Pune',
            time: '18 min ago',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _DashboardContent._card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _DashboardContent._border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: const Color(0xFF85868A),
            size: 19,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  color: _DashboardContent._muted,
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ActivityRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF85868A),
          size: 19,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _DashboardContent._secondary,
              fontSize: 11,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RecentActivityRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const _RecentActivityRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _DashboardContent._cardLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF85868A),
              size: 17,
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
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _DashboardContent._muted,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF68696D),
              fontSize: 8.5,
            ),
          ),
        ],
      ),
    );
  }
}