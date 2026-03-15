import 'package:flutter/material.dart';

import '../../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/employee.dart';
import 'employee_role_selector.dart';

class EmployeesList extends StatelessWidget {
  final List<Employee> employees;
  final bool isOwner;
  final void Function(int employeeId, String newRole) onRoleChanged;
  final void Function(int employeeId) onRemove;

  const EmployeesList({
    super.key,
    required this.employees,
    required this.isOwner,
    required this.onRoleChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.people_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                S.of(context).noEmployeesYet,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: employees.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final employee = employees[index];
        return _EmployeeTile(
          employee: employee,
          isOwner: isOwner,
          onRoleChanged: (newRole) => onRoleChanged(employee.id, newRole),
          onRemove: () => onRemove(employee.id),
        );
      },
    );
  }
}

class _EmployeeTile extends StatelessWidget {
  final Employee employee;
  final bool isOwner;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onRemove;

  const _EmployeeTile({
    required this.employee,
    required this.isOwner,
    required this.onRoleChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _roleColor(employee.role),
        child: Text(
          employee.name.isNotEmpty ? employee.name[0].toUpperCase() : '?',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(employee.name.isNotEmpty ? employee.name : employee.email),
      subtitle: Text(employee.email),
      trailing: employee.isOwner
          ? Chip(
              label: Text(S.of(context).owner),
              backgroundColor: Colors.amber.shade100,
            )
          : isOwner
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 120,
                      child: EmployeeRoleSelector(
                        currentRole: employee.role,
                        onRoleChanged: onRoleChanged,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmRemove(context),
                    ),
                  ],
                )
              : Chip(label: Text(_roleLabel(context, employee.role))),
    );
  }

  void _confirmRemove(BuildContext context) {
    final l = S.of(context);
    final name = employee.name.isNotEmpty ? employee.name : employee.email;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.removeEmployeeTitle),
        content: Text(l.removeEmployeeMessage(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(ctx).pop();
              onRemove();
            },
            child: Text(l.removeEmployee),
          ),
        ],
      ),
    );
  }

  Color _roleColor(String role) {
    switch (role) {
      case 'OWNER':
        return Colors.amber.shade700;
      case 'MANAGER':
        return Colors.blue;
      case 'STAFF':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _roleLabel(BuildContext context, String role) {
    final l = S.of(context);
    switch (role) {
      case 'MANAGER':
        return l.manager;
      case 'STAFF':
        return l.staff;
      default:
        return role;
    }
  }
}
