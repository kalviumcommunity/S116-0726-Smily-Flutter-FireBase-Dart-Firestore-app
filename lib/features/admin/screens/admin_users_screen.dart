import 'package:flutter/material.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  int _selectedTab = 0;
  String _searchQuery = '';

  static const Color _background = Color(0xFF030405);
  static const Color _card = Color(0xFF111214);
  static const Color _cardLight = Color(0xFF1A1B1D);
  static const Color _border = Color(0xFF242528);
  static const Color _muted = Color(0xFF7E7F83);
  static const Color _secondary = Color(0xFFB0B1B4);

  final List<Map<String, dynamic>> _riders = [
    {
      'name': 'Aman Sharma',
      'email': 'aman@example.com',
      'phone': '+91 98765 43210',
      'status': 'Active',
    },
    {
      'name': 'Rahul Mehta',
      'email': 'rahul@example.com',
      'phone': '+91 98765 12345',
      'status': 'Active',
    },
    {
      'name': 'Priya Shah',
      'email': 'priya@example.com',
      'phone': '+91 99887 66554',
      'status': 'Active',
    },
  ];

  final List<Map<String, dynamic>> _drivers = [
    {
      'name': 'Vikram Singh',
      'email': 'vikram@example.com',
      'phone': '+91 98765 11111',
      'status': 'Online',
      'accountStatus': 'Active',
      'vehicle': 'Maruti Suzuki Dzire',
      'registration': 'MH 12 AB 1234',
    },
    {
      'name': 'Rohit Patil',
      'email': 'rohit@example.com',
      'phone': '+91 98765 22222',
      'status': 'Offline',
      'accountStatus': 'Active',
      'vehicle': 'Hyundai Aura',
      'registration': 'MH 14 CD 5678',
    },
    {
      'name': 'Arjun Verma',
      'email': 'arjun@example.com',
      'phone': '+91 98765 33333',
      'status': 'Online',
      'accountStatus': 'Active',
      'vehicle': 'Honda City',
      'registration': 'MH 12 EF 9012',
    },
  ];

  List<Map<String, dynamic>> get _filteredUsers {
    final users = _selectedTab == 0 ? _riders : _drivers;

    if (_searchQuery.trim().isEmpty) {
      return users;
    }

    final query = _searchQuery.toLowerCase().trim();

    return users.where((user) {
      return user['name']
              .toString()
              .toLowerCase()
              .contains(query) ||
          user['email']
              .toString()
              .toLowerCase()
              .contains(query) ||
          user['phone']
              .toString()
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _background,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 22),
              _buildTabs(),
              const SizedBox(height: 14),
              _buildSearch(),
              const SizedBox(height: 20),
              _buildSectionHeader(),
              const SizedBox(height: 10),
              _buildUserList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Users',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Manage riders and drivers',
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
        children: [
          _buildTab(
            label: 'Riders',
            selected: _selectedTab == 0,
            onTap: () {
              setState(() {
                _selectedTab = 0;
                _searchQuery = '';
              });
            },
          ),
          _buildTab(
            label: 'Drivers',
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
              fontWeight:
                  selected ? FontWeight.w600 : FontWeight.w400,
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
          hintText: 'Search users',
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

  Widget _buildSectionHeader() {
    final users = _filteredUsers;

    return Row(
      children: [
        Text(
          _selectedTab == 0 ? 'RIDERS' : 'DRIVERS',
          style: const TextStyle(
            color: _muted,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
        const Spacer(),
        Text(
          '${users.length} ${users.length == 1 ? 'user' : 'users'}',
          style: const TextStyle(
            color: Color(0xFF68696D),
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  Widget _buildUserList() {
    final users = _filteredUsers;

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

  Widget _buildUserCard(Map<String, dynamic> user) {
    final bool isDriver = _selectedTab == 1;
    final bool isOnline =
        isDriver && user['status'] == 'Online';

    final String accountStatus = isDriver
        ? user['accountStatus'].toString()
        : user['status'].toString();

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
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['email'].toString(),
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
                  isDriver
                      ? user['status'].toString()
                      : accountStatus,
                  isOnline: isDriver ? isOnline : true,
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
              user['phone'].toString(),
            ),
            if (isDriver) ...[
              const SizedBox(height: 10),
              _buildDetailRow(
                Icons.directions_car_outlined,
                'Vehicle',
                user['vehicle'].toString(),
              ),
              const SizedBox(height: 10),
              _buildDetailRow(
                Icons.confirmation_number_outlined,
                'Registration',
                user['registration'].toString(),
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
    required bool isOnline,
  }) {
    final bool active = status == 'Active' || isOnline;

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
            color: active
                ? Colors.white
                : const Color(0xFF68696D),
            size: 7,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: active
                  ? const Color(0xFFB8B9BC)
                  : const Color(0xFF68696D),
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
            'Try a different search.',
            style: TextStyle(
              color: _muted,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    final bool isDriver = _selectedTab == 1;

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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF353639),
                        borderRadius:
                            BorderRadius.circular(4),
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
                          borderRadius:
                              BorderRadius.circular(14),
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
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              user['name'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isDriver ? 'Driver' : 'Rider',
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
                    user['email'].toString(),
                  ),
                  const SizedBox(height: 12),
                  _buildSheetInfo(
                    Icons.phone_outlined,
                    'Phone',
                    user['phone'].toString(),
                  ),
                  if (isDriver) ...[
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.directions_car_outlined,
                      'Vehicle',
                      user['vehicle'].toString(),
                    ),
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.confirmation_number_outlined,
                      'Registration',
                      user['registration'].toString(),
                    ),
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.circle_outlined,
                      'Availability',
                      user['status'].toString(),
                    ),
                    const SizedBox(height: 12),
                    _buildSheetInfo(
                      Icons.verified_user_outlined,
                      'Account',
                      user['accountStatus'].toString(),
                    ),
                  ],
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        _toggleAccountStatus(user);
                        Navigator.pop(sheetContext);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFF303135),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(13),
                        ),
                      ),
                      child: Text(
                        _accountActionText(user, isDriver),
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
                      onPressed: () {
                        Navigator.pop(sheetContext);
                      },
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

  String _accountActionText(
    Map<String, dynamic> user,
    bool isDriver,
  ) {
    final String status = isDriver
        ? user['accountStatus'].toString()
        : user['status'].toString();

    return status == 'Active'
        ? 'Deactivate Account'
        : 'Activate Account';
  }

  void _toggleAccountStatus(
    Map<String, dynamic> user,
  ) {
    final bool isDriver = _selectedTab == 1;

    setState(() {
      if (isDriver) {
        user['accountStatus'] =
            user['accountStatus'] == 'Active'
                ? 'Inactive'
                : 'Active';
      } else {
        user['status'] =
            user['status'] == 'Active'
                ? 'Inactive'
                : 'Active';
      }
    });

    final String status = isDriver
        ? user['accountStatus'].toString()
        : user['status'].toString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _cardLight,
        content: Text(
          '${user['name']} account is now $status',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}