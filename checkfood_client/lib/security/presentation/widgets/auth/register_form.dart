import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../validators/auth_validators.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../domain/usecases/auth/params/auth_params.dart';
import '../../utils/clipboard_hygiene.dart';
import 'password_strength_indicator.dart';

/// Formulář pro registraci nového uživatele.
///
/// Volitelně přijímá [onSubmit] callback; pokud není zadán, odesílá událost přímo do [AuthBloc].
class RegisterForm extends StatefulWidget {
  final void Function(RegisterParams params)? onSubmit;

  const RegisterForm({super.key, this.onSubmit});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isOwnerRegistration = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onRegisterPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      double? lat, lng;
      if (_isOwnerRegistration) {
        try {
          final position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
          );
          lat = position.latitude;
          lng = position.longitude;
        } catch (_) {}
      }

      final params = RegisterParams(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        ownerRegistration: _isOwnerRegistration,
        latitude: lat,
        longitude: lng,
      );

      if (mounted) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(params);
        } else {
          context.read<AuthBloc>().add(AuthEvent.registerRequested(params));
        }
        // Clipboard hygiene after submit — see LoginForm for rationale.
        ClipboardHygiene.clearSensitive();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _firstNameController,
                  label: l.firstName,
                  icon: Icons.person_outline,
                  validator: (v) => AuthValidators.validateRequired(v, l.firstName),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _lastNameController,
                  label: l.lastName,
                  icon: Icons.person,
                  validator:
                      (v) => AuthValidators.validateRequired(v, l.lastName),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _emailController,
            label: l.email,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: AuthValidators.validateEmail,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _passwordController,
            label: l.password,
            icon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            onChanged: (_) => setState(() {}),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed:
                  () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
            validator: AuthValidators.validatePassword,
          ),
          const SizedBox(height: 8),

          PasswordStrengthIndicator(password: _passwordController.text),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _confirmPasswordController,
            label: l.confirmPassword,
            icon: Icons.lock_reset,
            obscureText: !_isPasswordVisible,
            validator:
                (v) => AuthValidators.validateConfirmPassword(
                  v,
                  _passwordController.text,
                ),
          ),
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CheckboxListTile(
              title: Text(
                l.registerAsOwner,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                l.registerAsOwnerSubtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              value: _isOwnerRegistration,
              onChanged: (val) => setState(() => _isOwnerRegistration = val ?? false),
              activeColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            ),
          ),
          const SizedBox(height: 24),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return ElevatedButton(
                onPressed: isLoading ? null : _onRegisterPressed,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Text(
                          l.createAccount,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
