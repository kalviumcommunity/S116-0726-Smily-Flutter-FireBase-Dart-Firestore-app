import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class RideResultsScreen extends StatelessWidget {
  const RideResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      appBar: AppBar(
        backgroundColor: const Color(0xFF030405),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text(
          'Available Rides',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          children: [
            _buildRouteSummary(),
            const SizedBox(height: 24),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    '4 rides available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildFilterButton(context),
              ],
            ),

            const SizedBox(height: 14),

            _RideCard(
              driverName: 'Aman Sharma',
              rating: '4.9',
              car: 'Maruti Suzuki Dzire',
              time: '09:30 AM',
              arrival: '10:15 AM',
              price: '₹120',
              seats: '2 seats left',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rideDetails,
                );
              },
            ),

            const SizedBox(height: 12),

            _RideCard(
              driverName: 'Rohan Mehta',
              rating: '4.8',
              car: 'Hyundai Aura',
              time: '10:00 AM',
              arrival: '10:50 AM',
              price: '₹105',
              seats: '3 seats left',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rideDetails,
                );
              },
            ),

            const SizedBox(height: 12),

            _RideCard(
              driverName: 'Arjun Kapoor',
              rating: '4.7',
              car: 'Honda City',
              time: '10:30 AM',
              arrival: '11:20 AM',
              price: '₹140',
              seats: '1 seat left',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rideDetails,
                );
              },
            ),

            const SizedBox(height: 12),

            _RideCard(
              driverName: 'Vikram Singh',
              rating: '4.9',
              car: 'Tata Nexon',
              time: '11:15 AM',
              arrival: '12:05 PM',
              price: '₹115',
              seats: '2 seats left',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.rideDetails,
                );
              },
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Prices and availability may change.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.32),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteSummary() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF111214),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF252629),
        ),
      ),
      child: Row(
        children: [
          Column(
            children: [
              const Icon(
                Icons.radio_button_checked_rounded,
                color: Colors.white,
                size: 14,
              ),
              Container(
                height: 24,
                width: 1,
                color: const Color(0xFF38393C),
              ),
              const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
                size: 17,
              ),
            ],
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Connaught Place',
                  style: TextStyle(
                    color: Color(0xFFB5B6BA),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.swap_vert_rounded,
            color: Color(0xFF77787C),
            size: 21,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0xFF111214),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          builder: (sheetContext) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Sort & Filter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 22),
                    _FilterOption(
                      icon: Icons.currency_rupee_rounded,
                      title: 'Lowest price',
                      onTap: () => Navigator.pop(sheetContext),
                    ),
                    _FilterOption(
                      icon: Icons.access_time_rounded,
                      title: 'Earliest departure',
                      onTap: () => Navigator.pop(sheetContext),
                    ),
                    _FilterOption(
                      icon: Icons.star_outline_rounded,
                      title: 'Highest rated',
                      onTap: () => Navigator.pop(sheetContext),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF111214),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF252629),
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.tune_rounded,
              color: Colors.white70,
              size: 17,
            ),
            SizedBox(width: 7),
            Text(
              'Filter',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RideCard extends StatelessWidget {
  final String driverName;
  final String rating;
  final String car;
  final String time;
  final String arrival;
  final String price;
  final String seats;
  final VoidCallback onTap;

  const _RideCard({
    required this.driverName,
    required this.rating,
    required this.car,
    required this.time,
    required this.arrival,
    required this.price,
    required this.seats,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withValues(alpha: 0.05),
        highlightColor: Colors.white.withValues(alpha: 0.03),
        child: Ink(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: const Color(0xFF111214),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF252629),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Color(0xFF202124),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driverName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 13,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating,
                              style: const TextStyle(
                                color: Color(0xFF9B9C9F),
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                car,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF77787C),
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 17),

              Container(
                height: 1,
                color: const Color(0xFF242528),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.radio_button_checked_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                      Container(
                        height: 21,
                        width: 1,
                        color: const Color(0xFF38393C),
                      ),
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          arrival,
                          style: const TextStyle(
                            color: Color(0xFF85868A),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    seats,
                    style: const TextStyle(
                      color: Color(0xFF999A9D),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF66676A),
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _FilterOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white70,
              size: 21,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF66676A),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}