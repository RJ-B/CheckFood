import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/auth/request/login_request_model.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      // Získání info o zařízení
      final deviceInfoPlugin = DeviceInfoPlugin();
      String deviceIdentifier = const Uuid().v4();
      String deviceName = 'Unknown Device';
      String deviceType = 'UNKNOWN';

      try {
        if (Platform.isAndroid) {
          final androidInfo = await deviceInfoPlugin.androidInfo;
          deviceName = '${androidInfo.brand} ${androidInfo.model}';
          deviceIdentifier = androidInfo.id;
          deviceType = 'ANDROID';
        } else if (Platform.isIOS) {
          final iosInfo = await deviceInfoPlugin.iosInfo;
          deviceName = iosInfo.name;
          deviceIdentifier = iosInfo.identifierForVendor ?? const Uuid().v4();
          deviceType = 'IOS';
        }
      } catch (e) {
        debugPrint('⚠️ Chyba device info: $e');
      }

      final request = LoginRequestModel(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        deviceIdentifier: deviceIdentifier,
        deviceName: deviceName,
        deviceType: deviceType,
      );

      // Pouze odešleme event. O zbytek se postará Bloc a LoginPage.
      if (mounted) {
        context.read<AuthBloc>().add(AuthEvent.loginRequested(request));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Zadejte email';
              if (!value.contains('@')) return 'Neplatný formát';
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Heslo
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Heslo',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                },
              ),
            ),
            validator:
                (value) => (value?.isEmpty ?? true) ? 'Zadejte heslo' : null,
          ),

          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                /* TODO: Reset hesla */
              },
              child: const Text('Zapomněli jste heslo?'),
            ),
          ),
          const SizedBox(height: 16),

          // Tlačítko s indikátorem načítání
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse:
                    () => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onLoginPressed,
                        child: const Text('Přihlásit se'),
                      ),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
