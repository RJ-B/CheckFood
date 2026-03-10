import 'package:flutter/material.dart';

class StartEditorButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartEditorButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: Colors.green,
      ),
      icon: const Icon(Icons.add),
      label: const Text('Přidat stůl', style: TextStyle(fontSize: 16)),
      onPressed: onPressed,
    );
  }
}
