import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/main_scaffold.dart';

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
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=8',
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
            _sectionTitle('Account'),
            _settingsTile(context, 'Upravit profil', Icons.arrow_forward_ios),
            _settingsTile(context, 'Země', Icons.arrow_forward_ios),
            _settingsTile(context, 'Notifikace', Icons.arrow_forward_ios),
            _settingsTile(context, 'Změna údajů', Icons.arrow_forward_ios),
            const SizedBox(height: 10),
            _sectionTitle('Obecné'),
            _settingsTile(context, 'Podpora', Icons.arrow_forward_ios),
            _settingsTile(
              context,
              'Podmínky používání',
              Icons.arrow_forward_ios,
            ),
            _settingsTile(context, 'Pozvat přátele', Icons.arrow_forward_ios),
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

  Widget _settingsTile(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(title),
          trailing: Icon(icon, size: 16),
          onTap: () {
            if (title == 'Upravit profil') {
              Navigator.pushNamed(context, '/edit-profile');
            } else {
              // Můžeš přidat další navigace podle názvu
            }
          },
        ),
      ),
    );
  }
}
