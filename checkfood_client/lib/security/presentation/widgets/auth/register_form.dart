import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Services

// BLoC a State
import '../../../validators/auth_validators.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

// Domain Params
import '../../../domain/usecases/auth/params/auth_params.dart';
import 'password_strength_indicator.dart';

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
    // 1. Validace UI formuláře (včetně shody hesel)
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      final params = RegisterParams(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      if (mounted) {
        if (widget.onSubmit != null) {
          widget.onSubmit!(params);
        } else {
          context.read<AuthBloc>().add(AuthEvent.registerRequested(params));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            label: 'Potvrzení hesla',
            icon: Icons.lock_reset,
            obscureText: !_isPasswordVisible,
            // Validace shody hesel probíhá ZDE na klientovi
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
