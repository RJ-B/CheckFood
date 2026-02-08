import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

// BLoC a State
import '../../../validators/auth_validators.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

// Modely
import '../../../data/models/auth/request/register_request_model.dart';
import 'password_strength_indicator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<Map<String, String>> _getDeviceData() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String identifier = const Uuid().v4();
    String name = 'Unknown Device';
    String type = 'UNKNOWN';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        name = '${androidInfo.brand} ${androidInfo.model}';
        identifier = androidInfo.id;
        type = 'ANDROID';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        name = iosInfo.name;
        identifier = iosInfo.identifierForVendor ?? const Uuid().v4();
        type = 'IOS';
      }
    } catch (e) {
      debugPrint('Chyba při získávání informací o zařízení: $e');
    }

    return {'id': identifier, 'name': name, 'type': type};
  }

  Future<void> _onRegisterPressed() async {
    // ✅ MANUÁLNÍ VALIDACE: Tady se poprvé aktivují a zobrazí chyby v polích
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      final deviceData = await _getDeviceData();

      final request = RegisterRequestModel(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        deviceIdentifier: deviceData['id']!,
        deviceName: deviceData['name']!,
        deviceType: deviceData['type']!,
      );

      if (mounted) {
        context.read<AuthBloc>().add(AuthEvent.registerRequested(request));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // 🛠️ KLÍČOVÁ ZMĚNA: Vypnuto automatické ověřování při interakci
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
                  label: 'Jméno',
                  icon: Icons.person_outline,
                  validator: (v) => AuthValidators.validateRequired(v, 'Jméno'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _lastNameController,
                  label: 'Příjmení',
                  icon: Icons.person,
                  validator:
                      (v) => AuthValidators.validateRequired(v, 'Příjmení'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: AuthValidators.validateEmail,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _passwordController,
            label: 'Heslo',
            icon: Icons.lock_outline,
            obscureText: !_isPasswordVisible,
            // 💡 REAKTIVITA: Tento setState zajišťuje, že se indikátor síly hesla překresluje v reálném čase
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

          // Indikátor síly hesla se mění hned, protože poslouchá controller a reaguje na setState výše
          PasswordStrengthIndicator(password: _passwordController.text),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Potvrzení hesla',
            icon: Icons.lock_reset,
            obscureText: !_isPasswordVisible,
            validator:
                (v) => AuthValidators.validateConfirmPassword(
                  v,
                  _passwordController.text,
                ),
          ),
          const SizedBox(height: 32),

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
                        : const Text(
                          'Vytvořit účet',
                          style: TextStyle(
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
