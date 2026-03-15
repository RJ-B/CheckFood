import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

// Bloc
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';

// Widgets
import '../../widgets/user/device/device_item_tile.dart';

import '../../../../../l10n/generated/app_localizations.dart';

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
    // ✅ 1. Načteme zařízení (to je hlavní účel této obrazovky)
    context.read<UserBloc>().add(const UserEvent.devicesRequested());
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _isRefreshing = true;
    });
    // ✅ 2. Refresh volá znovu načtení zařízení
    context.read<UserBloc>().add(const UserEvent.devicesRequested());
  }

  void _onLogoutDevice(int deviceId) {
    // ✅ 3. Logout s ID (int)
    context.read<UserBloc>().add(UserEvent.deviceLoggedOut(deviceId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).deviceManagementTitle), centerTitle: true),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            // Pokud jsme načetli data, vypneme refresh
            loaded: (_, __, ___, ____) {
              if (_isRefreshing) {
                setState(() {
                  _isRefreshing = false;
                });
              }
            },
            failure: (message) {
              setState(() {
                _isRefreshing = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final l = S.of(context);
          return state.maybeWhen(
            // ✅ 4. Destrukce stavu (profile, devices, notificationsEnabled, notificationsLoading)
            loaded: (profile, devices, _, __) {
              if (devices.isEmpty && !_isRefreshing) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.devices, size: 64, color: Colors.grey),
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

              return RefreshIndicator(
                onRefresh: _refreshDevices,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: devices.length,
                  separatorBuilder: (ctx, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    final device = devices[index];

                    return DeviceItemTile(
                      device: device,
                      // ✅ 5. isCurrentDevice z Entity
                      isCurrentDevice: device.isCurrentDevice,
                      // ✅ 6. Logout callback
                      onLogout: () {
                        // Pokud je to aktuální zařízení, měl by to být spíše "Logout z aplikace"
                        // což řeší DeviceItemTile obvykle skrytím tlačítka nebo jinou akcí.
                        // Zde voláme logout konkrétního ID.
                        _onLogoutDevice(device.id);
                      },
                      // Indikace načítání u konkrétní položky (volitelné)
                      // DeviceItemTile musí podporovat parametr isLoggingOut
                      // isLoggingOut: _loggingOutDeviceId == device.id,
                    );
                  },
                ),
              );
            },

            loading:
                () =>
                    _isRefreshing
                        ? const SizedBox.shrink() // Pokud refreshujeme, obsah zůstává (řeší RefreshIndicator)
                        : const Center(child: CircularProgressIndicator()),

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
                      Text(message, textAlign: TextAlign.center),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: _refreshDevices,
                        child: Text(l.retry),
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
