import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/ui_helpers.dart';
import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_event.dart';
import '../../bloc/user/user_state.dart';
import '../../widgets/user/device/device_item_tile.dart';

class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({super.key});

  @override
  State<DeviceManagementScreen> createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  bool _isRefreshing = false;

  // OPRAVA: Změněno na int, aby to sedělo na Entitu Device
  int? _loggingOutDeviceId;

  @override
  void initState() {
    super.initState();
    // Požadavek na načtení profilu
    context.read<UserBloc>().add(const UserEvent.profileRequested());
  }

  Future<void> _refreshDevices() async {
    setState(() {
      _isRefreshing = true;
    });
    context.read<UserBloc>().add(const UserEvent.profileRequested());
  }

  // OPRAVA: Metoda přijímá int (ID z databáze)
  void _onLogoutDevice(int deviceId) {
    setState(() {
      _loggingOutDeviceId = deviceId;
    });

    // Konverze int -> String pro BLoC (pokud BLoC očekává String)
    context.read<UserBloc>().add(
      UserEvent.deviceLoggedOut(deviceId.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Správa zařízení'), centerTitle: true),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (profile) {
              setState(() {
                _isRefreshing = false;
                _loggingOutDeviceId = null;
              });
            },
            failure: (message) {
              setState(() {
                _isRefreshing = false;
                _loggingOutDeviceId = null;
              });
              AppNotifications.showError(context, message);
            },
            orElse: () {
              if (_isRefreshing) {
                setState(() => _isRefreshing = false);
              }
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (profile) {
              final devices = profile.devices;

              if (devices.isEmpty && !_isRefreshing) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.devices, size: 64, color: Colors.grey),
                      const Gap(16),
                      Text(
                        'Žádná aktivní zařízení.',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(24),
                      ElevatedButton.icon(
                        onPressed: _refreshDevices,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Načíst znovu'),
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

                    // OPRAVA: Používáme vlastnost přímo z Entity.
                    // Backend/Mapper musí zajistit, že 'isCurrentDevice' je správně nastaveno.
                    final isCurrentDevice = device.isCurrentDevice;

                    return DeviceItemTile(
                      device: device, // Zde posíláme entitu s int ID
                      isCurrentDevice: isCurrentDevice,
                      onLogout: () => _onLogoutDevice(device.id),
                      isLoggingOut: _loggingOutDeviceId == device.id,
                    );
                  },
                ),
              );
            },

            loading:
                () =>
                    _isRefreshing
                        ? const SizedBox.shrink()
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
                        child: const Text('Zkusit znovu'),
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
