import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/profile/request/change_password_request_model.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';

// Import modelu

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllery
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureText = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      // Vytvoření modelu se správnými názvy parametrů
      final request = ChangePasswordRequestModel(
        currentPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmNewPassword: _confirmPasswordController.text,
      );

      context.read<UserBloc>().add(UserEvent.passwordChangeRequested(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.maybeWhen(
          passwordChangeSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Heslo bylo úspěšně změněno.'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          },
          failure: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // 1. Staré heslo
            TextFormField(
              controller: _oldPasswordController,
              obscureText: _obscureText,
              decoration: const InputDecoration(
                labelText: 'Staré heslo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator:
                  (v) => v?.isEmpty == true ? 'Zadejte staré heslo' : null,
            ),
            const SizedBox(height: 16),

            // 2. Nové heslo
            TextFormField(
              controller: _newPasswordController,
              obscureText: _obscureText,
              decoration: const InputDecoration(
                labelText: 'Nové heslo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              validator:
                  (v) => (v?.length ?? 0) < 6 ? 'Minimálně 6 znaků' : null,
            ),
            const SizedBox(height: 16),

            // 3. Potvrzení hesla
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Potvrzení hesla',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
              validator: (v) {
                if (v != _newPasswordController.text) {
                  return 'Hesla se neshodují';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Tlačítko
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  orElse:
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _onSubmit,
                          child: const Text('Změnit heslo'),
                        ),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
