import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/widgets/main_scaffold.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MainScaffold(
      currentIndex: 2,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?u=${authProvider.email ?? "default"}',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${authProvider.firstName ?? ''} ${authProvider.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authProvider.email ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _sectionTitle('Účet'),
            _settingsTile(
              context,
              'Upravit profil',
              Icons.edit,
              '/edit-profile',
            ),
            _settingsTile(context, 'Změna údajů', Icons.info_outline),
            const SizedBox(height: 10),
            _sectionTitle('Obecné'),
            _settingsTile(context, 'Podpora', Icons.support_agent),
            _settingsTile(context, 'Podmínky používání', Icons.policy),
            _settingsTile(context, 'Pozvat přátele', Icons.person_add_alt),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _settingsTile(
    BuildContext context,
    String title,
    IconData icon, [
    String? route,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(title),
          trailing: Icon(icon, size: 16),
          onTap: () {
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
        ),
      ),
    );
  }
}
