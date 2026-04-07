import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../l10n/generated/app_localizations.dart';

/// Dialog vysvětlující, proč je potřeba přístup k poloze, a umožňující uživateli
/// jej povolit nebo zadat polohu ručně.
class LocationPermissionDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LocationPermissionDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(l.locationPermissionTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined, size: 64, color: Colors.blue),
          const Gap(16),
          Text(
            l.locationPermissionDesc,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: onCancel, child: Text(l.enterManually)),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(l.allowInSystem),
        ),
      ],
    );
  }
}
