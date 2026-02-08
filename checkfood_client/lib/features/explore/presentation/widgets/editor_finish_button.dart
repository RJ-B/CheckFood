import 'package:flutter/material.dart';

class _FinishEditorButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _FinishEditorButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.red,
      ),
      icon: const Icon(Icons.check),
      label: const Text('Hotovo', style: TextStyle(fontSize: 16)),
      onPressed: onPressed,
    );
  }
}
