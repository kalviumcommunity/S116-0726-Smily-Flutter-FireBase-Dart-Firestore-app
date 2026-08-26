import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/user_model.dart';
import '../../../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/role_selector_card.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Form Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _vehicleRegController = TextEditingController();
  final _unionPermitController = TextEditingController();

  // Form State
  String _selectedRole = AppConstants.rolePassenger;
  String _vehicleType = AppConstants.vehicleAuto;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptedTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _vehicleRegController.dispose();
    _unionPermitController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptedTerms) {
      _showSnackBar(
        'Please accept the Terms of Service & Privacy Policy to register.',
        isError: true,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      DriverDetails? driverDetails;
      if (_selectedRole == AppConstants.roleDriver) {
        driverDetails = DriverDetails(
          uid: '',
          vehicleType: _vehicleType,
          vehicleRegistrationNumber: _vehicleRegController.text.trim().toUpperCase(),
          unionPermitNumber: _unionPermitController.text.trim().toUpperCase(),
        );
      }

      await _authService.registerUser(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        password: _passwordController.text,
        role: _selectedRole,
        driverDetails: driverDetails,
      );

      if (!mounted) return;

      _showSnackBar(
        'Account created successfully! Welcome to ${AppConstants.appName}.',
        isError: false,
      );

      // Navigate to main app flow / dashboard
      Navigator.of(context).pushReplacementNamed(
        _selectedRole == AppConstants.roleDriver ? '/driver-dashboard' : '/passenger-home',
      );
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? AppTheme.errorRed : AppTheme.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                // Header Logo & Branding
                _buildHeader(),
                const SizedBox(height: 28),

                // Role Selector Widget
                RoleSelectorCard(
                  selectedRole: _selectedRole,
                  onRoleSelected: (role) {
                    setState(() => _selectedRole = role);
                  },
                ),
                const SizedBox(height: 24),

                // Full Name Input
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'e.g. Rahul Sharma',
                  controller: _fullNameController,
                  prefixIcon: Icons.person_outline_rounded,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your full name';
                    }
                    if (val.trim().length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Email Address Input
                CustomTextField(
                  label: 'Email Address',
                  hintText: 'e.g. rahul@example.com',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(val.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Phone Number Input
                CustomTextField(
                  label: 'Phone Number',
                  hintText: 'e.g. +91 9876543210',
                  controller: _phoneController,
                  prefixIcon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (val.trim().length < 10) {
                      return 'Please enter a valid phone number (10+ digits)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Driver Conditional Fields Section
                if (_selectedRole == AppConstants.roleDriver) ...[
                  _buildDriverFields(),
                  const SizedBox(height: 18),
                ],

                // Password Input
                CustomTextField(
                  label: 'Password',
                  hintText: 'Minimum 6 characters',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePassword: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Confirm Password Input
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  prefixIcon: Icons.lock_clock_outlined,
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onTogglePassword: () {
                    setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (val != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Terms & Conditions Checkbox
                _buildTermsCheckbox(),
                const SizedBox(height: 24),

                // Primary Register Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: AppTheme.primaryAmber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppTheme.bgDark,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.bgDark,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: AppTheme.bgDark,
                              size: 20,
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 24),

                // Login Navigation Footer
                _buildLoginFooter(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: AppTheme.primaryAmber.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryAmber.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.electric_rickshaw_rounded,
            size: 38,
            color: AppTheme.primaryAmber,
          ),
        ),
        const SizedBox(height: 14),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Union',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryLight,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Ride',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryAmber,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Join the modern auto & cab dispatch network',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildDriverFields() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryAmber.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.assignment_ind_rounded, color: AppTheme.primaryAmber, size: 20),
              SizedBox(width: 8),
              Text(
                'Driver & Vehicle Details',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryAmber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Vehicle Type',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryLight,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildVehicleOption(
                  type: AppConstants.vehicleAuto,
                  label: 'Auto Rickshaw',
                  icon: Icons.electric_rickshaw_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildVehicleOption(
                  type: AppConstants.vehicleCab,
                  label: 'Cab / Taxi',
                  icon: Icons.local_taxi_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: 'Vehicle Registration Number',
            hintText: 'e.g. KA-01-AB-1234',
            controller: _vehicleRegController,
            prefixIcon: Icons.confirmation_number_outlined,
            textCapitalization: TextCapitalization.characters,
            validator: (val) {
              if (_selectedRole == AppConstants.roleDriver && (val == null || val.trim().isEmpty)) {
                return 'Please enter vehicle registration number';
              }
              return null;
            },
          ),
          const SizedBox(height: 14),
          CustomTextField(
            label: 'Union Permit Number',
            hintText: 'e.g. U-PERMIT-8849',
            controller: _unionPermitController,
            prefixIcon: Icons.verified_user_outlined,
            textCapitalization: TextCapitalization.characters,
            validator: (val) {
              if (_selectedRole == AppConstants.roleDriver && (val == null || val.trim().isEmpty)) {
                return 'Please enter your union permit number';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleOption({
    required String type,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = _vehicleType == type;

    return InkWell(
      onTap: () => setState(() => _vehicleType = type),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryAmber.withOpacity(0.2)
              : AppTheme.surfaceDark.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.primaryAmber : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppTheme.primaryAmber : AppTheme.textSecondaryLight,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppTheme.primaryAmber : AppTheme.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _acceptedTerms,
            onChanged: (val) => setState(() => _acceptedTerms = val ?? false),
            activeColor: AppTheme.primaryAmber,
            checkColor: AppTheme.bgDark,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            side: const BorderSide(color: AppTheme.textSecondaryLight, width: 1.5),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: AppTheme.textSecondaryLight),
                children: const [
                  TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: AppTheme.primaryAmber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: AppTheme.primaryAmber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: AppTheme.textSecondaryLight, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: const Text(
            'Log In',
            style: TextStyle(
              color: AppTheme.primaryAmber,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
