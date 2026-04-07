import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../domain/entities/device.dart';
import '../../../../../l10n/generated/app_localizations.dart';

/// Karta zobrazující informace o přihlášeném zařízení a akční tlačítka (odhlásit / smazat).
class DeviceItemTile extends StatelessWidget {
  final Device device;
  final VoidCallback? onLogout;
  final VoidCallback? onDelete;
  final bool isLoggingOut;
  final bool isDeleting;
  final bool isCurrentDevice;

  const DeviceItemTile({
    super.key,
    required this.device,
    this.onLogout,
    this.onDelete,
    this.isLoggingOut = false,
    this.isDeleting = false,
    this.isCurrentDevice = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final l = S.of(context);

    return Card(
      elevation: 0,
      color: isCurrentDevice
          ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
          : Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconForDeviceType(device.deviceType),
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    device.deviceName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: device.isActive
                                  ? AppColors.success
                                  : AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            device.isActive ? l.deviceActive : l.deviceInactive,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: device.isActive
                                  ? AppColors.success
                                  : AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l.lastActivity(dateFormat.format(device.lastLogin)),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: isCurrentDevice
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Text(
                              l.thisDevice,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isLoggingOut || isDeleting)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            else ...[
                              if (device.isActive)
                                IconButton(
                                  onPressed: onLogout,
                                  icon: const Icon(Icons.logout, size: 26),
                                  color: AppColors.textSecondary,
                                  tooltip: l.logoutDevice,
                                  padding: const EdgeInsets.all(10),
                                ),
                              IconButton(
                                onPressed: onDelete,
                                icon: const Icon(Icons.delete_outline, size: 26),
                                color: AppColors.error,
                                tooltip: l.deleteDevice,
                                padding: const EdgeInsets.all(10),
                              ),
                            ],
                          ],
                        ),
                ),
              ],
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
