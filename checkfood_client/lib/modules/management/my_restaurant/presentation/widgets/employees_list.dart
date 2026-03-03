import 'package:flutter/material.dart';

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
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No employees yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
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
              label: const Text('Owner'),
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
              : Chip(label: Text(_roleLabel(employee.role))),
    );
  }

  void _confirmRemove(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove Employee'),
        content: Text('Are you sure you want to remove ${employee.name.isNotEmpty ? employee.name : employee.email}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(ctx).pop();
              onRemove();
            },
            child: const Text('Remove'),
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
