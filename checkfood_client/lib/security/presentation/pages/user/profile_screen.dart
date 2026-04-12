import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:app_settings/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/colors.dart';

import '../../../domain/entities/device.dart';
import '../../../domain/entities/user_profile.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../../../core/locale/locale_cubit.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../data/models/profile/request/update_profile_request_model.dart';
import '../../widgets/user/change_password_form.dart';
import '../../widgets/user/device/device_item_tile.dart';
import '../../widgets/user/logout_button.dart';
import '../../widgets/user/profile/profile_header.dart';
import '../../widgets/user/profile/profile_menu_item.dart';

/// Hlavní obrazovka profilu uživatele.
///
/// Zobrazuje přehled účtu, umožňuje správu osobních údajů, hesla, zařízení,
/// jazyka a notifikací. Obsahuje také kontaktní podporu a tlačítko pro odhlášení.
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

  void _showChangePasswordDialog(BuildContext context) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(l.changePassword)),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: ChangePasswordForm(),
          ),
        ),
      ),
    );
  }

  void _showPersonalDataDialog(BuildContext context) {
    final state = context.read<UserBloc>().state;
    final l = S.of(context);

    String firstName = '';
    String lastName = '';
    String email = '';
    String phone = '';
    String addressStreet = '';
    String addressCity = '';
    String addressPostalCode = '';
    String addressCountry = '';
    state.maybeWhen(
      loaded: (profile, _, __, ___) {
        firstName = profile.firstName;
        lastName = profile.lastName;
        email = profile.email;
        phone = profile.phone;
        addressStreet = profile.addressStreet;
        addressCity = profile.addressCity;
        addressPostalCode = profile.addressPostalCode;
        addressCountry = profile.addressCountry;
      },
      orElse: () {},
    );

    final firstNameController = TextEditingController(text: firstName);
    final lastNameController = TextEditingController(text: lastName);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);
    final streetController = TextEditingController(text: addressStreet);
    final cityController = TextEditingController(text: addressCity);
    final postalCodeController = TextEditingController(text: addressPostalCode);
    final countryController = TextEditingController(text: addressCountry);
    final formKey = GlobalKey<FormState>();
    bool submitted = false;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(l.personalData)),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l.basicInfoSubtitle,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: firstNameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.firstName,
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty) ? l.enterFirstName : null,
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: lastNameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.lastName,
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty) ? l.enterLastName : null,
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: emailController,
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: l.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                      filled: true,
                    ),
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: l.phoneLabel,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        (value == null || value.trim().isEmpty) ? l.phoneRequired : null,
                  ),
                  const Gap(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l.addressLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const Gap(8),
                  TextFormField(
                    controller: streetController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.streetLabel,
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const Gap(12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: cityController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: l.cityLabel,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const Gap(8),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: postalCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: l.postalCodeLabel,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),
                  TextFormField(
                    controller: countryController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.countryLabel,
                      prefixIcon: const Icon(Icons.flag_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const Gap(20),
                  BlocConsumer<UserBloc, UserState>(
                    listenWhen: (prev, curr) {
                      if (!submitted) return false;
                      return prev.maybeMap(loading: (_) => true, orElse: () => false);
                    },
                    listener: (context, state) {
                      state.maybeWhen(
                        loaded: (_, __, ___, ____) {
                          submitted = false;
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l.profileUpdated),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        },
                        failure: (msg) {
                          submitted = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(msg), backgroundColor: AppColors.error),
                          );
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      final isLoading = state.maybeMap(
                        loading: (_) => true,
                        orElse: () => false,
                      );
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    submitted = true;
                                    FocusScope.of(context).unfocus();
                                    context.read<UserBloc>().add(
                                      UserEvent.profileUpdated(
                                        UpdateProfileRequestModel(
                                          firstName: firstNameController.text.trim(),
                                          lastName: lastNameController.text.trim(),
                                          phone: phoneController.text.trim(),
                                          addressStreet: streetController.text.trim().isEmpty
                                              ? null
                                              : streetController.text.trim(),
                                          addressCity: cityController.text.trim().isEmpty
                                              ? null
                                              : cityController.text.trim(),
                                          addressPostalCode: postalCodeController.text.trim().isEmpty
                                              ? null
                                              : postalCodeController.text.trim(),
                                          addressCountry: countryController.text.trim().isEmpty
                                              ? null
                                              : countryController.text.trim(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(l.saveChanges),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDevicesDialog(BuildContext context, List<Device> devices) {
    final l = S.of(context);
    final bloc = context.read<UserBloc>();

    Future<bool> confirm(BuildContext parentCtx, String title, String content, {bool isDestructive = false}) async {
      return await showDialog<bool>(
        context: parentCtx,
        builder: (c) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 52, vertical: 24),
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(l.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(
                isDestructive ? l.delete : l.logout,
                style: isDestructive ? const TextStyle(color: AppColors.error) : null,
              ),
            ),
          ],
        ),
      ) ?? false;
    }

    showDialog(
      context: context,
      builder: (ctx) => BlocBuilder<UserBloc, UserState>(
        builder: (blocCtx, state) {
          final currentDevices = state.maybeWhen(
            loaded: (_, devices, __, ___) => devices,
            orElse: () => devices,
          );

          return AlertDialog(
            title: Row(
              children: [
                Expanded(child: Text(l.deviceManagement)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
            content: SizedBox(
              width: double.maxFinite,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: currentDevices.isEmpty
                    ? Center(child: Text(l.noOtherDevices))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: currentDevices.length,
                        itemBuilder: (_, index) {
                          final device = currentDevices[index];
                          return DeviceItemTile(
                            device: device,
                            isCurrentDevice: device.isCurrentDevice,
                            onLogout: device.isCurrentDevice
                                ? null
                                : () async {
                                    final confirmed = await confirm(
                                      ctx,
                                      l.logoutDeviceDialogTitle,
                                      l.logoutDeviceDialogContent,
                                    );
                                    if (confirmed) {
                                      bloc.add(UserEvent.deviceLoggedOut(device.id));
                                    }
                                  },
                            onDelete: device.isCurrentDevice
                                ? null
                                : () async {
                                    final confirmed = await confirm(
                                      ctx,
                                      l.deleteDeviceDialogTitle,
                                      l.deleteDeviceDialogContent,
                                      isDestructive: true,
                                    );
                                    if (confirmed) {
                                      bloc.add(UserEvent.deviceDeleted(device.id));
                                    }
                                  },
                          );
                        },
                      ),
              ),
            ),
            actions: [
              if (currentDevices.any((d) => !d.isCurrentDevice))
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final confirmed = await confirm(
                              ctx,
                              l.logoutAllDevicesDialogTitle,
                              l.logoutAllDevicesDialogContent,
                            );
                            if (confirmed) {
                              bloc.add(const UserEvent.allDevicesLogoutRequested());
                            }
                          },
                          child: const Text('Odhlásit vše'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            final confirmed = await confirm(
                              ctx,
                              l.deleteAllDevicesDialogTitle,
                              l.deleteAllDevicesDialogContent,
                              isDestructive: true,
                            );
                            if (confirmed) {
                              bloc.add(const UserEvent.allDevicesDeleteRequested());
                            }
                          },
                          child: const Text(
                            'Smazat vše',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
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
                  backgroundColor: AppColors.success,
                ),
              );
            },
            failure: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: AppColors.error),
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
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      ProfileHeader(profile: profile),
                      const Gap(24),
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
                        color: AppColors.error,
                      ),
                      const Gap(16),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textMuted),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(
                            const UserEvent.profileRequested(),
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
        _buildSectionHeader(l.sectionMyAccount),
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: l.personalData,
          subtitle: l.personalDataSubtitle,
          onTap: () => _showPersonalDataDialog(context),
        ),

        const Gap(16),

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

        _buildSectionHeader(l.sectionApp),
        ProfileMenuItem(
          icon: Icons.language,
          title: l.language,
          subtitle: l.languageSubtitle,
          onTap: () => _showLanguageDialog(context),
        ),
        ProfileMenuItem(
          icon: Icons.notifications_none,
          title: l.pushNotifications,
          subtitle: 'Spravovat v nastavení zařízení',
          onTap: () => AppSettings.openAppSettings(type: AppSettingsType.notification),
        ),
        ProfileMenuItem(
          icon: Icons.help_outline,
          title: l.help,
          onTap: () => _showHelpDialog(context),
        ),
        ProfileMenuItem(
          icon: Icons.support_agent,
          title: l.contactSupport,
          subtitle: '+420 731 753 765',
          onTap: () => _showContactSupportDialog(context),
        ),
      ],
    );
  }

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

  Widget _helpItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 4),
          Text(answer, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(l.help)),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _helpItem('Jak vytvořím rezervaci?', 'V sekci Explore vyberte restauraci, zvolte datum, čas a počet osob a potvrďte rezervaci.'),
              _helpItem('Jak zruším rezervaci?', 'V sekci Moje rezervace klikněte na rezervaci a zvolte možnost zrušit.'),
              _helpItem('Jak změním heslo?', 'V Můj Profil → Zabezpečení → Změna hesla.'),
              _helpItem('Jak přidám restauraci?', 'Zaregistrujte se jako vlastník restaurace a vyplňte formulář pro přidání restaurace.'),
              _helpItem('Jak kontaktuji podporu?', 'V Můj Profil → Kontaktovat podporu, nebo zavolejte na +420 731 753 765.'),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactSupportDialog(BuildContext context) {
    final l = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Expanded(child: Text(l.contactSupport)),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.support_agent, size: 48, color: AppColors.primary),
            const Gap(16),
            const Text(
              'Potřebujete pomoc? Kontaktujte nás:',
              textAlign: TextAlign.center,
            ),
            const Gap(16),
            ListTile(
              leading: const Icon(Icons.phone, color: AppColors.primary),
              title: const Text('+420 731 753 765'),
              subtitle: const Text('Po–Pá 9:00–17:00'),
              onTap: () => launchUrl(Uri.parse('tel:+420731753765')),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: AppColors.primary),
              title: const Text('podpora@checkfood.cz'),
              onTap: () => launchUrl(Uri.parse('mailto:podpora@checkfood.cz')),
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
            color: AppColors.textMuted,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
