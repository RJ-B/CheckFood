import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

/// Dialog pro dokončení profilu po prvním přihlášení přes sociální poskytovatele.
///
/// Umožňuje vyplnit jméno, příjmení a telefonní číslo. Dialog nelze zavřít bez akce.
class ProfileCompletionDialog extends StatefulWidget {
  final String? initialFirstName;
  final String? initialLastName;
  final void Function(String firstName, String lastName, String phone) onSave;

  const ProfileCompletionDialog({
    super.key,
    this.initialFirstName,
    this.initialLastName,
    required this.onSave,
  });

  @override
  State<ProfileCompletionDialog> createState() => _ProfileCompletionDialogState();
}

class _ProfileCompletionDialogState extends State<ProfileCompletionDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName ?? '');
    _lastNameController = TextEditingController(text: widget.initialLastName ?? '');
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dokončete svůj profil'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pro lepší zážitek prosím vyplňte své údaje.',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Jméno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Jméno je povinné' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Příjmení',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Příjmení je povinné' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Telefonní číslo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
                hintText: '+420 ...',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
          },
          child: const Text('Přeskočit'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.pop(context);
              widget.onSave(
                _firstNameController.text.trim(),
                _lastNameController.text.trim(),
                _phoneController.text.trim(),
              );
            }
          },
          child: const Text('Uložit'),
        ),
      ],
    );
  }
}
