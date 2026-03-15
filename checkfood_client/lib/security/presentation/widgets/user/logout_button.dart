import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout),
        label: Text(l.logout),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red,
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          side: BorderSide(color: Colors.red.shade100),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l.logoutTitle),
            content: Text(l.logoutConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.read<AuthBloc>().add(
                    const AuthEvent.logoutRequested(),
                  );
                },
                child: Text(
                  l.logout,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
