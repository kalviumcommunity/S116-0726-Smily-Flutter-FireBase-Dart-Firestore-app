import 'package:flutter/material.dart';
import '../../../core/widgets/city_map_widget.dart';
import '../../../models/ride_model.dart';
import '../../../models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/admin_service.dart';
import '../../../services/driver_service.dart';
import '../../../services/ride_service.dart';
import 'admin_users_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
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
              color: selected ? Colors.white : const Color(0xFF68696D),
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF68696D),
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  const _DashboardContent();

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

  final AdminService _adminService = AdminService();
  final RideService _rideService = RideService();
  final DriverService _driverService = DriverService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: _adminService.streamDashboardMetrics(),
      builder: (context, snapshot) {
        final metrics = snapshot.data ?? {};

        final activeDriversCount = (metrics['onlineDrivers'] as int?) ?? 0;
        final activeRidesCount = (metrics['activeRides'] as int?) ?? 0;
        final pendingRidesCount = (metrics['pendingRides'] as int?) ?? 0;
        final ridesTodayCount = (metrics['ridesTodayCount'] as int?) ?? 0;
        final completedTodayCount = (metrics['completedRidesTodayCount'] as int?) ?? 0;
        final earningsToday = (metrics['totalEarningsToday'] as double?) ?? 0.0;

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
              _buildSectionTitle('UNION LIVE FLEET CITY MAP'),
              const SizedBox(height: 10),
              const CityMapWidget(
                locationText: 'Metro Union Central Dispatch',
                height: 190,
                showRoute: true,
              ),
              const SizedBox(height: 22),
              _buildSectionTitle('REAL-TIME OVERVIEW'),
              const SizedBox(height: 10),
              _buildStatsGrid(
                activeDrivers: activeDriversCount.toString(),
                activeRides: activeRidesCount.toString(),
                pendingRides: pendingRidesCount.toString(),
                todayRides: ridesTodayCount.toString(),
              ),
              const SizedBox(height: 22),
              _buildSectionTitle('OPERATIONAL PERFORMANCE'),
              const SizedBox(height: 10),
              _buildRideActivity(
                activeDrivers: activeDriversCount.toString(),
                completedToday: completedTodayCount.toString(),
                earningsToday: '₹${earningsToday.toStringAsFixed(0)}',
              ),
              const SizedBox(height: 22),
              _buildSectionTitle('DEMAND ZONES ANALYTICS'),
              const SizedBox(height: 10),
              _buildZonalDemandCard(),
              const SizedBox(height: 22),
              _buildSectionTitle('PEAK DEMAND HOURS'),
              const SizedBox(height: 10),
              _buildPeakHoursCard(),
              const SizedBox(height: 22),
              _buildSectionTitle('UNASSIGNED DISPATCH QUEUE'),
              const SizedBox(height: 10),
              _buildUnassignedQueueStream(),
              const SizedBox(height: 22),
              _buildSectionTitle('LIVE FLEET RIDE FEED'),
              const SizedBox(height: 10),
              _buildLiveFeedStream(),
            ],
          ),
        );
      },
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
                'Union Dispatcher Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Live fleet operations & zonal intelligence',
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
                  'Automated Dispatch System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Connected to Firestore real-time cluster',
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
              'LIVE',
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

  Widget _buildStatsGrid({
    required String activeDrivers,
    required String activeRides,
    required String pendingRides,
    required String todayRides,
  }) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.55,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _StatCard(
          icon: Icons.people_outline_rounded,
          title: 'Online Drivers',
          value: activeDrivers,
        ),
        _StatCard(
          icon: Icons.directions_car_outlined,
          title: 'Active Rides',
          value: activeRides,
        ),
        _StatCard(
          icon: Icons.pending_actions_rounded,
          title: 'Pending / Unassigned',
          value: pendingRides,
        ),
        _StatCard(
          icon: Icons.event_available_outlined,
          title: "Today's Total Requests",
          value: todayRides,
        ),
      ],
    );
  }

  Widget _buildRideActivity({
    required String activeDrivers,
    required String completedToday,
    required String earningsToday,
  }) {
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
      child: Column(
        children: [
          _ActivityRow(
            icon: Icons.directions_car_outlined,
            title: 'Online fleet size',
            value: activeDrivers,
          ),
          const Divider(
            height: 22,
            color: Color(0xFF202124),
          ),
          _ActivityRow(
            icon: Icons.route_outlined,
            title: 'Completed rides today',
            value: completedToday,
          ),
          const Divider(
            height: 22,
            color: Color(0xFF202124),
          ),
          _ActivityRow(
            icon: Icons.currency_rupee_rounded,
            title: "Today's total gross fare",
            value: earningsToday,
          ),
        ],
      ),
    );
  }

  Widget _buildZonalDemandCard() {
    return FutureBuilder<Map<String, int>>(
      future: _adminService.getZonalDemandAnalytics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: Colors.white),
          ));
        }

        final zones = snapshot.data ?? {};

        if (zones.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _border),
            ),
            child: const Text('Not enough ride data for zonal demand analytics.',
                style: TextStyle(color: _muted, fontSize: 12)),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: zones.entries.take(5).map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white70, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _cardLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${entry.value} requests',
                        style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildPeakHoursCard() {
    return FutureBuilder<Map<String, int>>(
      future: _adminService.getPeakHoursAnalytics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: Colors.white),
          ));
        }

        final peakHours = snapshot.data ?? {};
        final activeHours = peakHours.entries.where((e) => e.value > 0).toList();
        activeHours.sort((a, b) => b.value.compareTo(a.value));

        if (activeHours.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _border),
            ),
            child: const Text('Not enough ride request timestamps to calculate peak hours.',
                style: TextStyle(color: _muted, fontSize: 12)),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: _border),
          ),
          child: Column(
            children: activeHours.take(4).map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded, color: Colors.white70, size: 16),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      '${entry.value} rides',
                      style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildUnassignedQueueStream() {
    return StreamBuilder<List<RideModel>>(
      stream: _rideService.streamAllRides(),
      builder: (context, snapshot) {
        final rides = snapshot.data ?? [];
        final unassigned = rides.where((r) => r.status == 'requested' || (r.status == 'assigned' && r.driverId == null)).toList();

        if (unassigned.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: _border),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle_outline_rounded, color: Colors.white38, size: 20),
                SizedBox(width: 10),
                Text('No pending unassigned ride requests.', style: TextStyle(color: _muted, fontSize: 12)),
              ],
            ),
          );
        }

        return Column(
          children: unassigned.map((ride) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ride.pickupLocation} → ${ride.dropLocation}',
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('Passenger: ${ride.passengerName} (${ride.passengerPhone})',
                          style: const TextStyle(color: _muted, fontSize: 11)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showManualDispatchSheet(ride),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Dispatch', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          )).toList(),
        );
      },
    );
  }

  void _showManualDispatchSheet(RideModel ride) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Manual Driver Assignment Override',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text('Select an available driver for ride #${ride.id.substring(0, 6)}...',
                    style: const TextStyle(color: _muted, fontSize: 12)),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<List<UserModel>>(
                    stream: _driverService.streamAvailableDriverUsers(vehicleType: ride.vehicleType),
                    builder: (context, snapshot) {
                      final drivers = snapshot.data ?? [];
                      if (drivers.isEmpty) {
                        return const Center(
                          child: Text('No online drivers available to assign.', style: TextStyle(color: Colors.white70)),
                        );
                      }
                      return ListView.builder(
                        itemCount: drivers.length,
                        itemBuilder: (context, index) {
                          final driver = drivers[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF202124),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text(driver.fullName, style: const TextStyle(color: Colors.white)),
                            subtitle: Text('${driver.driverDetails?.vehicleType.toUpperCase()} - ${driver.phoneNumber}',
                                style: const TextStyle(color: Colors.white54, fontSize: 11)),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                final messenger = ScaffoldMessenger.of(context);
                                Navigator.pop(sheetContext);
                                await _rideService.adminAssignDriver(
                                  rideId: ride.id,
                                  driverId: driver.uid,
                                  driverName: driver.fullName,
                                  driverPhone: driver.phoneNumber,
                                );
                                messenger.showSnackBar(
                                  SnackBar(content: Text('Assigned to ${driver.fullName}!')),
                                );
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                              child: const Text('Assign'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiveFeedStream() {
    return StreamBuilder<List<RideModel>>(
      stream: _rideService.streamAllRides(),
      builder: (context, snapshot) {
        final rides = snapshot.data ?? [];
        if (rides.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(17), border: Border.all(color: _border)),
            child: const Text('No rides logged in database yet.', style: TextStyle(color: _muted, fontSize: 12)),
          );
        }

        return Column(
          children: rides.take(5).map((ride) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(16), border: Border.all(color: _border)),
            child: Row(
              children: [
                const Icon(Icons.route_outlined, color: Colors.white70, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${ride.pickupLocation} → ${ride.dropLocation}',
                          style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 3),
                      Text('Driver: ${ride.driverName ?? "Unassigned"} • Status: ${ride.status.toUpperCase()}',
                          style: const TextStyle(color: _muted, fontSize: 10.5)),
                    ],
                  ),
                ),
                Text('₹${ride.fare.toStringAsFixed(0)}', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
              ],
            ),
          )).toList(),
        );
      },
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
        color: _DashboardContentState._card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _DashboardContentState._border,
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
                  color: _DashboardContentState._muted,
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
              color: _DashboardContentState._secondary,
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
