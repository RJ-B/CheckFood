import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../l10n/generated/app_localizations.dart';

class StartEditorButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartEditorButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: AppColors.primary,
      ),
      icon: const Icon(Icons.add),
      label: Text(l.addTable, style: const TextStyle(fontSize: 16)),
      onPressed: onPressed,
    );
  }
}
