import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Domain Entities
import '../../../domain/entities/device.dart';
import '../../../domain/entities/user_profile.dart';

// Bloc
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';

// Locale
import '../../../../core/locale/locale_cubit.dart';
import '../../../../l10n/generated/app_localizations.dart';

// Widgets
import '../../widgets/user/change_password_form.dart';
import '../../widgets/user/device/device_item_tile.dart';
import '../../widgets/user/logout_button.dart';
import '../../widgets/user/profile/profile_header.dart';
import '../../widgets/user/profile/profile_menu_item.dart';
import 'personal_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ 1. Načteme profil
    context.read<UserBloc>().add(const UserEvent.profileRequested());
    // ✅ 2. Načteme i zařízení (protože je zobrazujeme v menu)
    context.read<UserBloc>().add(const UserEvent.devicesRequested());
  }

  // --- 1. ZMĚNA HESLA ---
  void _showChangePasswordDialog(BuildContext context) {
    final l = S.of(context);
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
                    l.changePassword,
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
    final l = S.of(context);
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l.activeDevices),
            content: SizedBox(
              width: double.maxFinite,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child:
                    devices.isEmpty
                        ? Center(child: Text(l.noOtherDevices))
                        : ListView.builder(
                          shrinkWrap: true,
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            final device = devices[index];
                            return DeviceItemTile(
                              device: device,
                              isCurrentDevice: device.isCurrentDevice,
                              onLogout: () {
                                context.read<UserBloc>().add(
                                  UserEvent.deviceLoggedOut(device.id),
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
                child: Text(l.close),
              ),
              if (devices.length > 1)
                TextButton(
                  onPressed: () {
                    context.read<UserBloc>().add(
                      const UserEvent.allDevicesLogoutRequested(),
                    );
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    l.logoutOthers,
                    style: const TextStyle(color: Colors.red),
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
        title: Text(S.of(context).profile),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            devicesLogoutSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).loggedOutFromDevices),
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
            loaded: (profile, devices, notificationsEnabled, notificationsLoading) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(
                    const UserEvent.profileRequested(),
                  );
                  context.read<UserBloc>().add(
                    const UserEvent.devicesRequested(),
                  );
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ProfileHeader(profile: profile),
                      const Gap(24),
                      // ✅ Předáváme profil I zařízení
                      _buildMenuSection(context, profile, devices),
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
                        onPressed: () {
                          context.read<UserBloc>().add(
                            const UserEvent.profileRequested(),
                          );
                          context.read<UserBloc>().add(
                            const UserEvent.devicesRequested(),
                          );
                        },
                        child: Text(S.of(context).retry),
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

  Widget _buildMenuSection(
    BuildContext context,
    UserProfile profile,
    List<Device> devices,
  ) {
    final l = S.of(context);
    return Column(
      children: [
        // --- SEKCE: MŮJ ÚČET ---
        _buildSectionHeader(l.sectionMyAccount),
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: l.personalData,
          subtitle: l.personalDataSubtitle,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PersonalDataScreen(),
              ),
            );
          },
        ),
        ProfileMenuItem(
          icon: Icons.calendar_month_outlined,
          title: l.myReservations,
          subtitle: l.myReservationsSubtitle,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l.reservationsModuleSoon)),
            );
          },
        ),

        const Gap(16),

        // --- SEKCE: ZABEZPEČENÍ ---
        _buildSectionHeader(l.sectionSecurity),
        if (profile.authProvider == 'LOCAL')
          ProfileMenuItem(
            icon: Icons.lock_outline,
            title: l.changePassword,
            onTap: () => _showChangePasswordDialog(context),
          ),
        if (profile.authProvider != 'LOCAL')
          ProfileMenuItem(
            icon: Icons.lock_outline,
            title: l.loginVia(profile.authProvider == 'GOOGLE' ? 'Google' : 'Apple'),
            subtitle: l.passwordManagedByProvider,
            onTap: () {},
          ),
        ProfileMenuItem(
          icon: Icons.devices,
          title: l.deviceManagement,
          subtitle: l.activeDevicesCount(devices.length),
          onTap: () => _showDevicesDialog(context, devices),
        ),

        const Gap(16),

        // --- SEKCE: APLIKACE ---
        _buildSectionHeader(l.sectionApp),
        // --- JAZYK ---
        ProfileMenuItem(
          icon: Icons.language,
          title: l.language,
          subtitle: l.languageSubtitle,
          onTap: () => _showLanguageDialog(context),
        ),
        // --- PUSH NOTIFIKACE SWITCH ---
        BlocSelector<UserBloc, UserState, ({bool enabled, bool loading})>(
          selector: (state) => state.maybeWhen(
            loaded: (_, __, notificationsEnabled, notificationsLoading) =>
                (enabled: notificationsEnabled, loading: notificationsLoading),
            orElse: () => (enabled: false, loading: false),
          ),
          builder: (context, notifState) {
            return SwitchListTile(
              secondary: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.notifications_none,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
              title: Text(
                l.pushNotifications,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  notifState.enabled ? l.enabled : l.disabled,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ),
              value: notifState.enabled,
              onChanged: notifState.loading
                  ? null
                  : (value) {
                      context.read<UserBloc>().add(
                        UserEvent.notificationToggled(value),
                      );
                    },
            );
          },
        ),
        ProfileMenuItem(
          icon: Icons.help_outline,
          title: l.help,
          onTap: () {},
        ),
        ProfileMenuItem(
          icon: Icons.support_agent,
          title: l.contactSupport,
          onTap: () {},
        ),
      ],
    );
  }

  // --- 3. VOLBA JAZYKA (Dialog) ---
  void _showLanguageDialog(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(l.czech),
              value: 'cs',
              groupValue: localeCubit.state.languageCode,
              onChanged: (value) {
                localeCubit.setLocale(const Locale('cs', 'CZ'));
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<String>(
              title: Text(l.english),
              value: 'en',
              groupValue: localeCubit.state.languageCode,
              onChanged: (value) {
                localeCubit.setLocale(const Locale('en', 'US'));
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
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
