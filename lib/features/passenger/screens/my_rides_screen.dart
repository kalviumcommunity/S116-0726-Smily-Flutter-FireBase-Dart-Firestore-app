import 'package:flutter/material.dart';

class MyRidesScreen extends StatelessWidget {
  const MyRidesScreen({super.key});

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
          'My Rides',
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
            _buildSectionTitle('Upcoming'),
            const SizedBox(height: 12),
            _RideCard(
              status: 'Upcoming',
              statusIcon: Icons.schedule_rounded,
              driverName: 'Aman Sharma',
              vehicle: 'Maruti Suzuki Dzire',
              pickup: 'Current location',
              destination: 'Connaught Place',
              date: 'Tomorrow',
              time: '09:30 AM',
              price: '₹120',
              seats: '1 seat',
              onTap: () {
                _showRideDetails(context);
              },
            ),

            const SizedBox(height: 28),

            _buildSectionTitle('Past rides'),
            const SizedBox(height: 12),
            _RideCard(
              status: 'Completed',
              statusIcon: Icons.check_circle_outline_rounded,
              driverName: 'Rohan Mehta',
              vehicle: 'Hyundai Aura',
              pickup: 'Rajiv Chowk',
              destination: 'India Gate',
              date: 'Yesterday',
              time: '06:30 PM',
              price: '₹105',
              seats: '1 seat',
              onTap: () {
                _showRideDetails(context);
              },
            ),
            const SizedBox(height: 12),
            _RideCard(
              status: 'Completed',
              statusIcon: Icons.check_circle_outline_rounded,
              driverName: 'Vikram Singh',
              vehicle: 'Tata Nexon',
              pickup: 'Saket',
              destination: 'Hauz Khas',
              date: '28 Aug',
              time: '04:15 PM',
              price: '₹115',
              seats: '1 seat',
              onTap: () {
                _showRideDetails(context);
              },
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Your ride history',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.28),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _showRideDetails(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 28),
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
                  'Ride details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const _DetailRow(
                  icon: Icons.person_outline_rounded,
                  title: 'Driver',
                  value: 'Aman Sharma',
                ),
                const SizedBox(height: 15),
                const _DetailRow(
                  icon: Icons.directions_car_outlined,
                  title: 'Vehicle',
                  value: 'Maruti Suzuki Dzire',
                ),
                const SizedBox(height: 15),
                const _DetailRow(
                  icon: Icons.location_on_outlined,
                  title: 'Destination',
                  value: 'Connaught Place',
                ),
                const SizedBox(height: 15),
                const _DetailRow(
                  icon: Icons.currency_rupee_rounded,
                  title: 'Fare',
                  value: '₹120',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RideCard extends StatelessWidget {
  final String status;
  final IconData statusIcon;
  final String driverName;
  final String vehicle;
  final String pickup;
  final String destination;
  final String date;
  final String time;
  final String price;
  final String seats;
  final VoidCallback onTap;

  const _RideCard({
    required this.status,
    required this.statusIcon,
    required this.driverName,
    required this.vehicle,
    required this.pickup,
    required this.destination,
    required this.date,
    required this.time,
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
                    width: 44,
                    height: 44,
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
                        Text(
                          vehicle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF77787C),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        statusIcon,
                        color: Colors.white70,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                height: 1,
                color: const Color(0xFF242528),
              ),

              const SizedBox(height: 15),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.radio_button_checked_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                      Container(
                        width: 1,
                        height: 22,
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
                          pickup,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 17),
                        Text(
                          destination,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF85868A),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF85868A),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Text(
                    seats,
                    style: const TextStyle(
                      color: Color(0xFF77787C),
                      fontSize: 11,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFF18191B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white70,
            size: 19,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF85868A),
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}