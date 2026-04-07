import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/employee.dart';
import 'employee_role_selector.dart';

/// Scrollovatelný seznam dlaždic zaměstnanců s ovládáním pro změnu role a odebrání,
/// viditelným pouze pro majitele restaurace.
class EmployeesList extends StatelessWidget {
  final List<Employee> employees;
  final bool isOwner;
  final void Function(int employeeId, String newRole) onRoleChanged;
  final void Function(int employeeId) onRemove;
  final void Function(Employee employee)? onPermissions;

  const EmployeesList({
    super.key,
    required this.employees,
    required this.isOwner,
    required this.onRoleChanged,
    required this.onRemove,
    this.onPermissions,
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
              const Icon(Icons.people_outline, size: 64, color: AppColors.textMuted),
              const SizedBox(height: 16),
              Text(
                S.of(context).noEmployeesYet,
                style: const TextStyle(fontSize: 18, color: AppColors.textMuted),
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
          onPermissions: onPermissions != null ? () => onPermissions!(employee) : null,
        );
      },
    );
  }
}

/// Jeden řádek v [EmployeesList] zobrazující avatar zaměstnance, jméno/e-mail
/// a (pro majitele) výběr role, oprávnění a ovládání pro odebrání.
class _EmployeeTile extends StatelessWidget {
  final Employee employee;
  final bool isOwner;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onRemove;
  final VoidCallback? onPermissions;

  const _EmployeeTile({
    required this.employee,
    required this.isOwner,
    required this.onRoleChanged,
    required this.onRemove,
    this.onPermissions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: _roleColor(employee.role),
                child: Text(
                  employee.name.isNotEmpty ? employee.name[0].toUpperCase() : '?',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name.isNotEmpty ? employee.name : employee.email,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      employee.email,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (employee.isOwner)
                Chip(
                  label: Text(S.of(context).owner),
                  backgroundColor: Colors.amber.shade100,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
          if (!employee.isOwner && isOwner) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Row(
                children: [
                  Expanded(
                    child: EmployeeRoleSelector(
                      currentRole: employee.role,
                      onRoleChanged: onRoleChanged,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onPermissions,
                    icon: const Icon(Icons.security, size: 20),
                    color: AppColors.primary,
                    tooltip: 'Oprávnění',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.error,
                    onPressed: () => _confirmRemove(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                  ),
                ],
              ),
            ),
          ],
          if (!employee.isOwner && !isOwner)
            Padding(
              padding: const EdgeInsets.only(left: 52, top: 4),
              child: Chip(
                label: Text(_roleLabel(context, employee.role)),
                visualDensity: VisualDensity.compact,
              ),
            ),
        ],
      ),
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
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
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
        return AppColors.info;
      case 'STAFF':
        return AppColors.success;
      default:
        return AppColors.textMuted;
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
