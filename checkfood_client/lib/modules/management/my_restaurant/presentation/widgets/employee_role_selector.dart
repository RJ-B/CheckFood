import 'package:flutter/material.dart';

class EmployeeRoleSelector extends StatelessWidget {
  final String currentRole;
  final ValueChanged<String> onRoleChanged;
  final bool enabled;

  const EmployeeRoleSelector({
    super.key,
    required this.currentRole,
    required this.onRoleChanged,
    this.enabled = true,
  });

  static const _roles = ['MANAGER', 'STAFF'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _roles.contains(currentRole) ? currentRole : 'STAFF',
      decoration: const InputDecoration(
        labelText: 'Role',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: _roles.map((role) {
        return DropdownMenuItem(
          value: role,
          child: Text(_roleLabel(role)),
        );
      }).toList(),
      onChanged: enabled
          ? (value) {
              if (value != null) onRoleChanged(value);
            }
          : null,
    );
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'MANAGER':
        return 'Manager';
      case 'STAFF':
        return 'Staff';
      default:
        return role;
    }
  }
}
