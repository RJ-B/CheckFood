import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';

class LogoutButton extends StatelessWidget {
  // Tlačítko nepotřebuje žádná data o uživateli, jen kontext
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout),
        label: const Text('Odhlásit se'),
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
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Odhlášení'),
            content: const Text('Opravdu se chcete odhlásit ze svého účtu?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Zrušit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  // Zde voláme AuthBloc pro odhlášení
                  context.read<AuthBloc>().add(
                    const AuthEvent.logoutRequested(),
                  );
                },
                child: const Text(
                  'Odhlásit',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
