import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';

class RiderRegisterScreen extends StatefulWidget {
  const RiderRegisterScreen({super.key});

  @override
  State<RiderRegisterScreen> createState() => _RiderRegisterScreenState();
}

class _RiderRegisterScreenState extends State<RiderRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _isCreatingAccount = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _createAccount() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptedTerms) {
      _showMessage('Please accept the Terms & Conditions.');
      return;
    }

    setState(() {
      _isCreatingAccount = true;
    });

    // Frontend-only for now.
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    setState(() {
      _isCreatingAccount = false;
    });

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.passengerHome,
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFF17181A),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  String? _requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    final phone = value.replaceAll(RegExp(r'\D'), '');

    if (phone.length < 10) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // =========================
                // BACK BUTTON
                // =========================
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0C0E),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF292C30),
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // =========================
                // LOGO
                // =========================
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 145,
                    height: 62,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'UnionRide',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                // =========================
                // TITLE
                // =========================
                const Center(
                  child: Text(
                    'Create your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.7,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    'Join rides. Move together.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF909096),
                      fontSize: 17,
                    ),
                  ),
                ),

                const SizedBox(height: 38),

                // =========================
                // FULL NAME
                // =========================
                _FieldLabel(label: 'Full Name'),

                const SizedBox(height: 10),

                _RegisterField(
                  controller: _nameController,
                  hint: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) => _requiredValidator(
                    value,
                    'Please enter your full name',
                  ),
                ),

                const SizedBox(height: 22),

                // =========================
                // EMAIL
                // =========================
                _FieldLabel(label: 'Email Address'),

                const SizedBox(height: 10),

                _RegisterField(
                  controller: _emailController,
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: _emailValidator,
                ),

                const SizedBox(height: 22),

                // =========================
                // PHONE
                // =========================
                _FieldLabel(label: 'Phone Number'),

                const SizedBox(height: 10),

                _RegisterField(
                  controller: _phoneController,
                  hint: 'Enter your phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: _phoneValidator,
                ),

                const SizedBox(height: 22),

                // =========================
                // PASSWORD
                // =========================
                _FieldLabel(label: 'Password'),

                const SizedBox(height: 10),

                _RegisterField(
                  controller: _passwordController,
                  hint: 'Create a password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  validator: _passwordValidator,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF9B9BA2),
                      size: 23,
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // =========================
                // CONFIRM PASSWORD
                // =========================
                _FieldLabel(label: 'Confirm Password'),

                const SizedBox(height: 10),

                _RegisterField(
                  controller: _confirmPasswordController,
                  hint: 'Confirm your password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: _obscureConfirmPassword,
                  validator: _confirmPasswordValidator,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword =
                            !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF9B9BA2),
                      size: 23,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =========================
                // TERMS
                // =========================
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _acceptedTerms = !_acceptedTerms;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(top: 1),
                        decoration: BoxDecoration(
                          color: _acceptedTerms
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _acceptedTerms
                                ? Colors.white
                                : const Color(0xFF55575C),
                            width: 1.3,
                          ),
                        ),
                        child: _acceptedTerms
                            ? const Icon(
                                Icons.check_rounded,
                                color: Colors.black,
                                size: 17,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy.',
                          style: TextStyle(
                            color: Color(0xFFA5A5AC),
                            fontSize: 14.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // CREATE ACCOUNT
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 62,
                  child: ElevatedButton(
                    onPressed: _isCreatingAccount
                        ? null
                        : _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFF242424),
                      foregroundColor: Colors.black,
                      disabledForegroundColor:
                          const Color(0xFF777777),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: _isCreatingAccount
                        ? const SizedBox(
                            width: 23,
                            height: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 17,
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 26),

                // =========================
                // LOGIN
                // =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 15.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// FIELD LABEL
// =====================================================

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFD7D7DB),
          fontSize: 15.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// =====================================================
// REGISTER FIELD
// =====================================================

class _RegisterField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextCapitalization textCapitalization;

  const _RegisterField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      textCapitalization: textCapitalization,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF777980),
          fontSize: 16,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFA6A6AD),
          size: 23,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF0C0D0F),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 19,
        ),
        errorStyle: const TextStyle(
          color: Color(0xFFD0D0D0),
          fontSize: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFF2D3034),
            width: 1.1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFF68686D),
            width: 1.1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}