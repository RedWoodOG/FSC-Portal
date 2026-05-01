import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import 'auth_state.dart';

/// Security settings screen for changing password and managing PIN.
class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  // Password change
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  // PIN
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  String? _passwordMessage;
  bool _passwordSuccess = false;
  String? _pinMessage;
  bool _pinSuccess = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    final authState = context.read<AuthState>();
    final current = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      setState(() {
        _passwordMessage = 'All fields are required.';
        _passwordSuccess = false;
      });
      return;
    }

    if (newPass.length < 6) {
      setState(() {
        _passwordMessage = 'New password must be at least 6 characters.';
        _passwordSuccess = false;
      });
      return;
    }

    if (newPass != confirm) {
      setState(() {
        _passwordMessage = 'New passwords do not match.';
        _passwordSuccess = false;
      });
      return;
    }

    final success = await authState.changePassword(current, newPass);
    setState(() {
      if (success) {
        _passwordMessage = 'Password changed successfully.';
        _passwordSuccess = true;
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } else {
        _passwordMessage = 'Current password is incorrect.';
        _passwordSuccess = false;
      }
    });
  }

  Future<void> _setPin() async {
    final authState = context.read<AuthState>();
    final pin = _pinController.text;
    final confirm = _confirmPinController.text;

    if (pin.isEmpty || confirm.isEmpty) {
      setState(() {
        _pinMessage = 'Both fields are required.';
        _pinSuccess = false;
      });
      return;
    }

    if (pin.length < 4 || pin.length > 8) {
      setState(() {
        _pinMessage = 'PIN must be 4-8 digits.';
        _pinSuccess = false;
      });
      return;
    }

    if (!RegExp(r'^\d+$').hasMatch(pin)) {
      setState(() {
        _pinMessage = 'PIN must contain only digits.';
        _pinSuccess = false;
      });
      return;
    }

    if (pin != confirm) {
      setState(() {
        _pinMessage = 'PINs do not match.';
        _pinSuccess = false;
      });
      return;
    }

    final success = await authState.setPin(pin);
    setState(() {
      if (success) {
        _pinMessage = 'PIN set successfully. You can now use it for quick unlock.';
        _pinSuccess = true;
        _pinController.clear();
        _confirmPinController.clear();
      } else {
        _pinMessage = 'Failed to set PIN.';
        _pinSuccess = false;
      }
    });
  }

  Future<void> _clearPin() async {
    final authState = context.read<AuthState>();
    await authState.clearPin();
    setState(() {
      _pinMessage = 'PIN removed.';
      _pinSuccess = true;
      _pinController.clear();
      _confirmPinController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Security Settings',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Change Password Section
            _buildSectionHeader('CHANGE PASSWORD'),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    obscure: _obscureCurrent,
                    onToggle: () => setState(() => _obscureCurrent = !_obscureCurrent),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: 'New Password',
                    obscure: _obscureNew,
                    onToggle: () => setState(() => _obscureNew = !_obscureNew),
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    obscure: _obscureConfirm,
                    onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  if (_passwordMessage != null) ...[
                    const SizedBox(height: 16),
                    _buildMessage(_passwordMessage!, _passwordSuccess),
                  ],
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'CHANGE PASSWORD',
                        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // PIN Section
            _buildSectionHeader('QUICK UNLOCK PIN'),
            const SizedBox(height: 8),
            Text(
              authState.hasPinSet
                  ? 'PIN is currently set. You can update or remove it below.'
                  : 'Set a 4-8 digit PIN for quick session unlock instead of typing your full password.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    style: const TextStyle(color: AppColors.textPrimary, letterSpacing: 8),
                    decoration: InputDecoration(
                      labelText: authState.hasPinSet ? 'New PIN' : 'PIN',
                      labelStyle: TextStyle(color: AppColors.textSecondary),
                      counterStyle: TextStyle(color: AppColors.textTertiary),
                      prefixIcon: const Icon(Icons.pin, color: AppColors.primary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    style: const TextStyle(color: AppColors.textPrimary, letterSpacing: 8),
                    decoration: InputDecoration(
                      labelText: 'Confirm PIN',
                      labelStyle: TextStyle(color: AppColors.textSecondary),
                      counterStyle: TextStyle(color: AppColors.textTertiary),
                      prefixIcon: const Icon(Icons.pin, color: AppColors.primary),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                  ),
                  if (_pinMessage != null) ...[
                    const SizedBox(height: 16),
                    _buildMessage(_pinMessage!, _pinSuccess),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _setPin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            authState.hasPinSet ? 'UPDATE PIN' : 'SET PIN',
                            style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
                          ),
                        ),
                      ),
                      if (authState.hasPinSet) ...[
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: _clearPin,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'REMOVE PIN',
                            style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.textTertiary,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.primary),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.textSecondary,
          ),
          onPressed: onToggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.surface,
      ),
    );
  }

  Widget _buildMessage(String text, bool isSuccess) {
    final color = isSuccess ? AppColors.success : AppColors.error;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle_outline : Icons.error_outline,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: color, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
