import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../data/models/profile/request/change_password_request_model.dart';
import '../../../validators/password_validator.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';

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
        confirmPassword: _confirmPasswordController.text,
      );

      context.read<UserBloc>().add(UserEvent.passwordChangeRequested(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        state.maybeWhen(
          passwordChangeSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l.changePasswordSuccess),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.pop(context);
          },
          failure: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: AppColors.error),
            );
          },
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _oldPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: l.oldPassword,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator:
                  (v) => v?.isEmpty == true ? l.enterOldPassword : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _newPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: l.newPassword,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
              ),
              validator: PasswordValidator.validate,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: l.confirmPassword,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
              validator: (v) => PasswordValidator.validateMatch(
                v,
                _newPasswordController.text,
              ),
            ),
            const SizedBox(height: 24),

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
                          child: Text(l.changePasswordButton),
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
