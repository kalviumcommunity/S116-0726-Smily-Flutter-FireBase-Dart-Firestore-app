import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  bool _notificationsEnabled = true;

  static const Color _background = Color(0xFF030405);
  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

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
                    _buildProfileCard(),
                    const SizedBox(height: 24),

                    _buildSectionTitle('DRIVER INFORMATION'),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      const [
                        _InfoItem(
                          icon: Icons.person_outline_rounded,
                          title: 'Full name',
                          value: 'Khushal Rajput',
                        ),
                        _InfoItem(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: '+91 98765 43210',
                        ),
                        _InfoItem(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          value: 'khushal@example.com',
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    _buildSectionTitle('VEHICLE INFORMATION'),
                    const SizedBox(height: 10),
                    _buildInfoCard(
                      const [
                        _InfoItem(
                          icon: Icons.directions_car_outlined,
                          title: 'Vehicle',
                          value: 'Maruti Suzuki Dzire',
                        ),
                        _InfoItem(
                          icon: Icons.confirmation_number_outlined,
                          title: 'Registration',
                          value: 'MH 12 AB 1234',
                        ),
                        _InfoItem(
                          icon: Icons.event_seat_outlined,
                          title: 'Available seats',
                          value: '3 seats',
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    _buildSectionTitle('PREFERENCES'),
                    const SizedBox(height: 10),

                    _buildActionCard(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      subtitle: 'Ride request notifications',
                      trailing: Switch.adaptive(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                        activeTrackColor: Colors.white,
                        activeThumbColor: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 9),

                    _buildActionCard(
                      icon: Icons.language_rounded,
                      title: 'Language',
                      subtitle: 'English',
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF6F7074),
                      ),
                      onTap: _showLanguageDialog,
                    ),

                    const SizedBox(height: 22),

                    _buildSectionTitle('SUPPORT'),
                    const SizedBox(height: 10),

                    _buildActionCard(
                      icon: Icons.help_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'Get help with your account or rides',
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF6F7074),
                      ),
                      onTap: _showSupportDialog,
                    ),

                    const SizedBox(height: 9),

                    _buildActionCard(
                      icon: Icons.info_outline_rounded,
                      title: 'About UnionRide',
                      subtitle: 'Version 1.0.0',
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF6F7074),
                      ),
                      onTap: _showAboutDialog,
                    ),

                    const SizedBox(height: 22),
                    _buildLogoutButton(),
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
    return const Text(
      'Profile',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: _cardLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 29,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khushal Rajput',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Driver',
                  style: TextStyle(
                    color: Color(0xFF85868A),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: _cardLight,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Text(
              'Driver',
              style: TextStyle(
                color: Color(0xFFB8B9BC),
                fontSize: 9.5,
                fontWeight: FontWeight.w600,
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

  Widget _buildInfoCard(List<_InfoItem> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _border,
        ),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];

            return Column(
              children: [
                _buildInfoRow(item),
                if (index != items.length - 1)
                  const Divider(
                    height: 1,
                    color: Color(0xFF202124),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(_InfoItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Icon(
            item.icon,
            color: const Color(0xFF85868A),
            size: 19,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Color(0xFF77787C),
                    fontSize: 9.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _cardLight,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
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
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF77787C),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.login,
            (route) => false,
          );
        },
        icon: const Icon(
          Icons.logout_rounded,
          size: 18,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFF303134),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
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
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.driverDashboard,
                  );
                },
              ),
              _buildNavItem(
                icon: Icons.directions_car_outlined,
                label: 'Rides',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(
                    AppRoutes.driverMyRides,
                  );
                },
              ),
              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                selected: true,
                onTap: () {},
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
              color: selected
                  ? Colors.white
                  : const Color(0xFF68696D),
              size: 22,
            ),
            const SizedBox(height: 5),
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

  void _showLanguageDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _card,
          title: const Text(
            'Language',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'English is currently selected.',
            style: TextStyle(color: _secondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSupportDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _card,
          title: const Text(
            'Help & Support',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'For account or ride-related help, contact UnionRide support.',
            style: TextStyle(color: _secondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'UnionRide',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.directions_car_rounded,
        color: Colors.white,
        size: 30,
      ),
      applicationLegalese: 'Ride together. Travel better.',
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });
}