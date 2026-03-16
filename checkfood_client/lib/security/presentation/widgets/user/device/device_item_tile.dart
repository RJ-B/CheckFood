import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../domain/entities/device.dart';
import '../../../../../l10n/generated/app_localizations.dart';

class DeviceItemTile extends StatelessWidget {
  final Device device;
  final VoidCallback onLogout;
  final bool isLoggingOut;
  final bool isCurrentDevice;

  const DeviceItemTile({
    super.key,
    required this.device,
    required this.onLogout,
    this.isLoggingOut = false,
    this.isCurrentDevice = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final l = S.of(context);

    return Card(
      elevation: 0,
      color:
          isCurrentDevice
              ? Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3)
              : Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Device icon
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

            // Device info
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
                      if (isCurrentDevice) ...[
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
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
                      ],
                    ],
                  ),
                  const Gap(4),
                  Text(
                    l.lastActivity(dateFormat.format(device.lastLogin)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Logout button
            if (isLoggingOut)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              IconButton(
                onPressed: isCurrentDevice ? null : onLogout,
                icon: Icon(
                  Icons.logout,
                  color: isCurrentDevice
                      ? AppColors.textMuted.withValues(alpha: 0.5)
                      : AppColors.error,
                ),
                tooltip: l.logoutDevice,
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
