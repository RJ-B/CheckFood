import 'package:checkfood_client/security/domain/entities/device.dart';
import 'package:checkfood_client/security/domain/entities/user_profile.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_bloc.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_event.dart';
import 'package:checkfood_client/security/presentation/bloc/user/user_state.dart';
import 'package:checkfood_client/security/presentation/pages/user/personal_data_screen.dart';
import 'package:checkfood_client/security/presentation/widgets/user/device/device_item_tile.dart';
import 'package:checkfood_client/security/presentation/widgets/user/logout_button.dart';
import 'package:checkfood_client/security/presentation/widgets/user/profile/profile_header.dart';
import 'package:checkfood_client/security/presentation/widgets/user/profile/profile_menu_item.dart';
import 'package:checkfood_client/security/presentation/widgets/user/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const UserEvent.profileRequested());
  }

  // --- 1. ZMĚNA HESLA ---
  void _showChangePasswordDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Změna hesla',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(16),
                  const ChangePasswordForm(),
                  const Gap(16),
                ],
              ),
            ),
          ),
    );
  }

  // --- 2. SPRÁVA ZAŘÍZENÍ (Dialog) ---
  void _showDevicesDialog(BuildContext context, List<Device> devices) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Aktivní zařízení'),
            content: SizedBox(
              width: double.maxFinite,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child:
                    devices.isEmpty
                        ? const Center(
                          child: Text('Žádná další aktivní zařízení.'),
                        )
                        : ListView.builder(
                          shrinkWrap: true,
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            final device = devices[index];
                            return DeviceItemTile(
                              device: device,
                              // Předpokládáme, že entita Device má isCurrentDevice,
                              // kterou nastavil backend nebo mapper.
                              isCurrentDevice: device.isCurrentDevice,
                              onLogout: () {
                                // OPRAVA: Přidáno .toString(), protože device.id je int,
                                // ale UserEvent očekává String.
                                context.read<UserBloc>().add(
                                  UserEvent.deviceLoggedOut(
                                    device.id.toString(),
                                  ),
                                );
                                Navigator.pop(ctx);
                              },
                            );
                          },
                        ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Zavřít'),
              ),
              if (devices.length > 1)
                TextButton(
                  onPressed: () {
                    context.read<UserBloc>().add(
                      const UserEvent.allDevicesLogoutRequested(),
                    );
                    Navigator.pop(ctx);
                  },
                  child: const Text(
                    'Odhlásit ostatní',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Můj Profil'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            devicesLogoutSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Byl jste odhlášen ze všech ostatních zařízení.',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            failure: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (profile) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(
                    const UserEvent.profileRequested(),
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ProfileHeader(profile: profile),
                      const Gap(24),
                      _buildMenuSection(context, profile),
                      const Gap(32),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: LogoutButton(),
                      ),
                      const Gap(40),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            failure:
                (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const Gap(16),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed:
                            () => context.read<UserBloc>().add(
                              const UserEvent.profileRequested(),
                            ),
                        child: const Text('Zkusit znovu'),
                      ),
                    ],
                  ),
                ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, UserProfile profile) {
    return Column(
      children: [
        // --- SEKCE: MŮJ ÚČET ---
        _buildSectionHeader('Můj Účet'),
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: 'Osobní údaje',
          subtitle: 'Jméno, příjmení a kontaktní údaje',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalDataScreen(),
              ),
            ).then((_) {
              // Volitelné obnovení dat po návratu
            });
          },
        ),
        ProfileMenuItem(
          icon: Icons.calendar_month_outlined,
          title: 'Moje rezervace',
          subtitle: 'Historie a nadcházející rezervace',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Modul Rezervace bude brzy dostupný.'),
              ),
            );
          },
        ),

        const Gap(16),

        // --- SEKCE: ZABEZPEČENÍ ---
        _buildSectionHeader('Zabezpečení'),
        ProfileMenuItem(
          icon: Icons.lock_outline,
          title: 'Změna hesla',
          onTap: () => _showChangePasswordDialog(context),
        ),
        ProfileMenuItem(
          icon: Icons.devices,
          title: 'Správa zařízení',
          subtitle: '${profile.devices.length} aktivních zařízení',
          onTap: () => _showDevicesDialog(context, profile.devices),
        ),

        const Gap(16),

        // --- SEKCE: APLIKACE ---
        _buildSectionHeader('Aplikace'),
        ProfileMenuItem(
          icon: Icons.notifications_none,
          title: 'Notifikace',
          onTap: () {
            // TODO: Implementovat nastavení notifikací
          },
        ),
        ProfileMenuItem(
          icon: Icons.help_outline,
          title: 'Nápověda',
          onTap: () {
            // TODO: Otevřít nápovědu
          },
        ),
        ProfileMenuItem(
          icon: Icons.support_agent,
          title: 'Kontaktovat podporu',
          onTap: () {
            // TODO: Kontakt
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
