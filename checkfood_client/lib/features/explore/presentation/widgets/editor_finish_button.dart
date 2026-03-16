import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../l10n/generated/app_localizations.dart';

class FinishEditorButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FinishEditorButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: AppColors.error,
      ),
      icon: const Icon(Icons.check),
      label: Text(l.done, style: const TextStyle(fontSize: 16)),
      onPressed: onPressed,
    );
  }
}
