import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/device.dart';

class DeviceItemTile extends StatelessWidget {
  final Device device;
  final VoidCallback onLogout;
  final bool isLoggingOut;

  // PŘIDÁNO: Musíme tento parametr definovat, aby ho šlo zvenčí naplnit
  final bool isCurrentDevice;

  const DeviceItemTile({
    super.key,
    required this.device,
    required this.onLogout,
    this.isLoggingOut = false,
    this.isCurrentDevice = false, // Defaultně false
  });

  @override
  Widget build(BuildContext context) {
    // Formátování data (např. 25.01.2026 14:30)
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    return Card(
      elevation: 0,
      // Pokud je to aktuální zařízení, podbarvíme ho jemně zeleně/primární barvou
      color:
          isCurrentDevice
              ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3)
              : Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Ikona zařízení
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForDeviceType(device.deviceType),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Gap(16),

            // Popis zařízení
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          device.deviceName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Štítek "Toto zařízení"
                      if (isCurrentDevice) ...[
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green),
                          ),
                          child: const Text(
                            'Toto zařízení',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(4),
                  Text(
                    'Poslední aktivita: ${dateFormat.format(device.lastLogin)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Tlačítko odhlášení
            if (isLoggingOut)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              IconButton(
                // Pokud je to aktuální zařízení, zakážeme tlačítko (vlastní logout je v menu)
                onPressed: isCurrentDevice ? null : onLogout,
                icon: Icon(
                  Icons.logout,
                  color:
                      isCurrentDevice
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.red,
                ),
                tooltip: 'Odhlásit zařízení',
              ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForDeviceType(String type) {
    switch (type.toUpperCase()) {
      case 'ANDROID':
        return Icons.android;
      case 'IOS':
        return Icons.phone_iphone;
      case 'WEB':
        return Icons.language;
      case 'WINDOWS':
      case 'MACOS':
      case 'LINUX':
        return Icons.computer;
      default:
        return Icons.smartphone;
    }
  }
}
