import 'package:flutter/material.dart';
import '../../../models/user_model.dart';
import '../../../services/admin_service.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  int _selectedTab = 0; // 0: Riders, 1: Drivers
  String _searchQuery = '';
  final AdminService _adminService = AdminService();

  static const Color _background = Color(0xFF030405);
  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _background,
      child: SafeArea(
        bottom: false,
        child: StreamBuilder<List<UserModel>>(
          stream: _adminService.streamAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            final allUsers = snapshot.data ?? [];
            final riders = allUsers.where((u) => u.role == 'passenger').toList();
            final drivers = allUsers.where((u) => u.role == 'driver').toList();

            final targetList = _selectedTab == 0 ? riders : drivers;

            final filteredUsers = targetList.where((u) {
              if (_searchQuery.trim().isEmpty) return true;
              final q = _searchQuery.toLowerCase().trim();
              return u.fullName.toLowerCase().contains(q) ||
                  u.email.toLowerCase().contains(q) ||
                  u.phoneNumber.toLowerCase().contains(q);
            }).toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 22),
                  _buildTabs(riders.length, drivers.length),
                  const SizedBox(height: 14),
                  _buildSearch(),
                  const SizedBox(height: 20),
                  _buildSectionHeader(filteredUsers.length),
                  const SizedBox(height: 10),
                  _buildUserList(filteredUsers),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Users & Fleet Management',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Manage union riders and verified drivers',
          style: TextStyle(
            color: _muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(int riderCount, int driverCount) {
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
        children: [
          _buildTab(
            label: 'Riders ($riderCount)',
            selected: _selectedTab == 0,
            onTap: () {
              setState(() {
                _selectedTab = 0;
                _searchQuery = '';
              });
            },
          ),
          _buildTab(
            label: 'Drivers ($driverCount)',
            selected: _selectedTab == 1,
            onTap: () {
              setState(() {
                _selectedTab = 1;
                _searchQuery = '';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? _cardLight : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : _muted,
              fontSize: 11.5,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _border,
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
        ),
        cursorColor: Colors.white,
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Color(0xFF77787C),
            size: 20,
          ),
          hintText: 'Search by name, email, or phone...',
          hintStyle: TextStyle(
            color: Color(0xFF68696D),
            fontSize: 11.5,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(int count) {
    return Row(
      children: [
        Text(
          _selectedTab == 0 ? 'REGISTERED RIDERS' : 'UNION DRIVERS',
          style: const TextStyle(
            color: _muted,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const Spacer(),
        Text(
          '$count ${count == 1 ? 'user' : 'users'}',
          style: const TextStyle(
            color: Color(0xFF68696D),
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildUserList(List<UserModel> users) {
    if (users.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: List.generate(
        users.length,
        (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == users.length - 1 ? 0 : 10,
            ),
            child: _buildUserCard(users[index]),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(UserModel user) {
    final bool isDriver = user.role == 'driver';
    final details = user.driverDetails;
    final bool isOnline = isDriver && (details?.isOnline ?? false);

    return GestureDetector(
      onTap: () => _showUserDetails(user),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: _border,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    color: _cardLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isDriver
                        ? Icons.drive_eta_outlined
                        : Icons.person_outline_rounded,
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
                        user.fullName.isNotEmpty ? user.fullName : 'Unnamed User',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email.isNotEmpty ? user.email : 'No email',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(
                  user.isActive ? (isDriver ? (isOnline ? 'Online' : 'Offline') : 'Active') : 'Inactive',
                  isActive: user.isActive,
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Divider(
              height: 1,
              color: Color(0xFF202124),
            ),
            const SizedBox(height: 13),
            _buildDetailRow(
              Icons.phone_outlined,
              'Phone',
              user.phoneNumber.isNotEmpty ? user.phoneNumber : 'N/A',
            ),
            if (isDriver && details != null) ...[
              const SizedBox(height: 10),
              _buildDetailRow(
                Icons.directions_car_outlined,
                'Vehicle',
                '${details.vehicleType.toUpperCase()} (${details.vehicleRegistrationNumber})',
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                Icons.confirmation_number_outlined,
                'Permit',
                details.unionPermitNumber.isNotEmpty ? details.unionPermitNumber : 'Standard Permit',
              ),
            ],
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tap for details',
                  style: TextStyle(
                    color: Color(0xFF68696D),
                    fontSize: 8.5,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF68696D),
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(
    String status, {
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: _cardLight,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: isActive ? Colors.white : const Color(0xFF68696D),
            size: 7,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: isActive ? const Color(0xFFB8B9BC) : const Color(0xFF68696D),
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF77787C),
          size: 16,
        ),
        const SizedBox(width: 9),
        Text(
          label,
          style: const TextStyle(
            color: _muted,
            fontSize: 9.5,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _secondary,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 48,
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
          Icon(
            Icons.search_off_rounded,
            color: Color(0xFF68696D),
            size: 38,
          ),
          SizedBox(height: 13),
          Text(
            'No users found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Try a different search or switch tab.',
            style: TextStyle(
              color: _muted,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(UserModel user) {
    final bool isDriver = user.role == 'driver';
    final details = user.driverDetails;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _background,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF353639),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _cardLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          isDriver
                              ? Icons.drive_eta_outlined
                              : Icons.person_outline_rounded,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isDriver ? 'Union Driver' : 'Passenger',
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSheetInfo(
                    Icons.email_outlined,
                    'Email',
                    user.email,
                  ),
                  const SizedBox(height: 12),
                  _buildSheetInfo(
                    Icons.phone_outlined,
                    'Phone',
                    user.phoneNumber,
                  ),
                  if (isDriver && details != null) ...[
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.directions_car_outlined,
                      'Vehicle',
                      '${details.vehicleType.toUpperCase()} (${details.vehicleRegistrationNumber})',
                    ),
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.confirmation_number_outlined,
                      'Union Permit',
                      details.unionPermitNumber,
                    ),
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.circle_outlined,
                      'Duty Status',
                      details.isOnline ? (details.isBusy ? 'Busy (On Ride)' : 'Online') : 'Offline',
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildSheetInfo(
                    Icons.verified_user_outlined,
                    'Account Status',
                    user.isActive ? 'Active' : 'Deactivated',
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(sheetContext);
                        await _adminService.toggleUserAccountStatus(user.uid, !user.isActive);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Account status updated to ${!user.isActive ? "Active" : "Deactivated"}'),
                            ),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF303135),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      child: Text(
                        user.isActive ? 'Deactivate Account' : 'Activate Account',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text(
                        'Close',
                        style: TextStyle(
                          color: _secondary,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSheetInfo(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF77787C),
          size: 17,
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: _muted,
            fontSize: 10,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _secondary,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    );
  }
}