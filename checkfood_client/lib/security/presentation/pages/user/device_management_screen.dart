import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/colors.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../widgets/user/device/device_item_tile.dart';
import '../../../../../l10n/generated/app_localizations.dart';

/// Obrazovka pro správu přihlášených zařízení uživatele.
///
/// Umožňuje odhlášení nebo smazání jednotlivých i všech zařízení (s výjimkou aktuálního).
class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({super.key});

  @override
  State<DeviceManagementScreen> createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const UserEvent.devicesRequested());
  }

  Future<void> _refreshDevices() async {
    setState(() => _isRefreshing = true);
    context.read<UserBloc>().add(const UserEvent.devicesRequested());
  }

  Future<bool> _confirmLogoutDevice(BuildContext context) async {
    final l = S.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.logoutDeviceDialogTitle),
            content: Text(l.logoutDeviceDialogContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.logout),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _confirmDeleteDevice(BuildContext context) async {
    final l = S.of(context);
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.deleteDeviceDialogTitle),
            content: Text(l.deleteDeviceDialogContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  l.delete,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _onLogoutAllDevices(BuildContext context) async {
    final l = S.of(context);
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.logoutAllDevicesDialogTitle),
            content: Text(l.logoutAllDevicesDialogContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.logoutAll),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed && context.mounted) {
      context.read<UserBloc>().add(const UserEvent.allDevicesLogoutRequested());
    }
  }

  Future<void> _onDeleteAllDevices(BuildContext context) async {
    final l = S.of(context);
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.deleteAllDevicesDialogTitle),
            content: Text(l.deleteAllDevicesDialogContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(
                  l.deleteAll,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed && context.mounted) {
      context.read<UserBloc>().add(const UserEvent.allDevicesDeleteRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).deviceManagementTitle),
        centerTitle: true,
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_, __, ___, ____) {
              if (_isRefreshing) {
                setState(() => _isRefreshing = false);
              }
            },
            devicesLogoutSuccess: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).loggedOutFromDevices),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            failure: (message) {
              setState(() => _isRefreshing = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final l = S.of(context);
          return state.maybeWhen(
            loaded: (profile, devices, _, __) {
              if (devices.isEmpty && !_isRefreshing) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.devices,
                        size: 64,
                        color: AppColors.textMuted,
                      ),
                      const Gap(16),
                      Text(
                        l.noActiveDevices,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(24),
                      ElevatedButton.icon(
                        onPressed: _refreshDevices,
                        icon: const Icon(Icons.refresh),
                        label: Text(l.loadAgain),
                      ),
                    ],
                  ),
                );
              }

              final hasOtherDevices =
                  devices.any((d) => !d.isCurrentDevice);

              return Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshDevices,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        itemCount: devices.length,
                        separatorBuilder: (ctx, index) => const Gap(12),
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          return DeviceItemTile(
                            device: device,
                            isCurrentDevice: device.isCurrentDevice,
                            onLogout: device.isCurrentDevice
                                ? null
                                : () async {
                                    final ok =
                                        await _confirmLogoutDevice(context);
                                    if (ok && context.mounted) {
                                      context.read<UserBloc>().add(
                                        UserEvent.deviceLoggedOut(device.id),
                                      );
                                    }
                                  },
                            onDelete: device.isCurrentDevice
                                ? null
                                : () async {
                                    final ok =
                                        await _confirmDeleteDevice(context);
                                    if (ok && context.mounted) {
                                      context.read<UserBloc>().add(
                                        UserEvent.deviceDeleted(device.id),
                                      );
                                    }
                                  },
                          );
                        },
                      ),
                    ),
                  ),

                  if (hasOtherDevices)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(),
                          const Gap(8),
                          OutlinedButton.icon(
                            onPressed: () => _onLogoutAllDevices(context),
                            icon: const Icon(Icons.logout),
                            label: Text(l.logoutAllDevices),
                          ),
                          const Gap(8),
                          OutlinedButton.icon(
                            onPressed: () => _onDeleteAllDevices(context),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.error,
                            ),
                            label: Text(
                              l.deleteAllDevices,
                              style: const TextStyle(color: AppColors.error),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },

            loading: () => _isRefreshing
                ? const SizedBox.shrink()
                : const Center(child: CircularProgressIndicator()),

            failure: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.error,
                  ),
                  const Gap(16),
                  Text(message, textAlign: TextAlign.center),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: _refreshDevices,
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            ),

            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
