import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class RoleSelectorCard extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleSelected;

  const RoleSelectorCard({
    Key? key,
    required this.selectedRole,
    required this.onRoleSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Select Account Type',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryLight,
              letterSpacing: 0.2,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: _buildRoleItem(
                role: AppConstants.rolePassenger,
                title: 'Passenger',
                subtitle: 'Book rides',
                icon: Icons.person_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildRoleItem(
                role: AppConstants.roleDriver,
                title: 'Driver',
                subtitle: 'Earn & Dispatch',
                icon: Icons.directions_car_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleItem({
    required String role,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool isSelected = selectedRole == role;

    return GestureDetector(
      onTap: () => onRoleSelected(role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryAmber.withOpacity(0.12)
              : AppTheme.cardDark,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppTheme.primaryAmber : AppTheme.surfaceDark,
            width: isSelected ? 2.0 : 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryAmber.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? AppTheme.primaryAmber
                      : AppTheme.textSecondaryLight,
                  size: 26,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppTheme.primaryAmber
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryAmber
                          : AppTheme.textSecondaryLight,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: AppTheme.bgDark,
                        )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? AppTheme.primaryAmber
                      : AppTheme.textPrimaryLight,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondaryLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
