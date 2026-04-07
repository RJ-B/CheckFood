import 'package:flutter/material.dart';

import '../../../../../../l10n/generated/app_localizations.dart';
import '../../data/models/request/add_employee_request_model.dart';

/// A dialog for inviting a new employee by email address and assigning an initial role.
class AddEmployeeDialog extends StatefulWidget {
  final void Function(AddEmployeeRequestModel request) onSubmit;

  const AddEmployeeDialog({super.key, required this.onSubmit});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _selectedRole = 'STAFF';

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return AlertDialog(
      title: Text(l.addEmployee),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l.email,
                hintText: l.emailHint,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l.emailRequired;
                }
                if (!value.contains('@')) {
                  return l.enterValidEmailShort;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                labelText: l.role,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'MANAGER', child: Text(l.manager)),
                DropdownMenuItem(value: 'STAFF', child: Text(l.staff)),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedRole = value);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l.add),
        ),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        AddEmployeeRequestModel(
          email: _emailController.text.trim(),
          role: _selectedRole,
        ),
      );
      Navigator.of(context).pop();
    }
  }
}
