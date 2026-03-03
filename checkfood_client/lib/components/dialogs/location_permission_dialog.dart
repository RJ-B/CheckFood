import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Povolení polohy'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined, size: 64, color: Colors.blue),
          const Gap(16),
          const Text(
            'Abychom vám mohli ukázat nejbližší restaurace v okolí a zajistit navigaci, potřebujeme přístup k vaší poloze.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Zadat ručně')),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Povolit v systému'),
        ),
      ],
    );
  }
}
