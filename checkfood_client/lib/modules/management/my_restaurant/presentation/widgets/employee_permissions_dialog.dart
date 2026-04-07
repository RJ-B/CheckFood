import 'package:flutter/material.dart';
import '../../../../../core/theme/colors.dart';
import '../../domain/entities/employee.dart';

const _permissionCategories = <String, Map<String, String>>{
  'Rezervace': {
    'CONFIRM_RESERVATION': 'Potvrzení',
    'EDIT_RESERVATION': 'Úprava',
    'CANCEL_RESERVATION': 'Zrušení',
    'CHECK_IN_RESERVATION': 'Check-in',
    'COMPLETE_RESERVATION': 'Dokončení',
    'EDIT_RESERVATION_DURATION': 'Délka rezervace',
  },
  'Restaurace': {
    'EDIT_RESTAURANT_INFO': 'Úprava info',
    'VIEW_RESTAURANT_INFO': 'Prohlížení info',
    'VIEW_STATISTICS': 'Statistiky',
  },
  'Správa': {
    'MANAGE_EMPLOYEES': 'Zaměstnanci',
    'MANAGE_MENU': 'Jídelní lístek',
  },
};

/// A dialog for viewing and toggling the granular permissions of a single employee.
class EmployeePermissionsDialog extends StatefulWidget {
  final Employee employee;
  final void Function(List<String> permissions) onSave;
  /// If null, all permissions are grantable (owner). If provided, only these can be toggled.
  final List<String>? grantablePermissions;

  const EmployeePermissionsDialog({
    super.key,
    required this.employee,
    required this.onSave,
    this.grantablePermissions,
  });

  @override
  State<EmployeePermissionsDialog> createState() =>
      _EmployeePermissionsDialogState();
}

class _EmployeePermissionsDialogState
    extends State<EmployeePermissionsDialog> {
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = Set<String>.from(widget.employee.permissions);
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.employee.name.isNotEmpty
        ? widget.employee.name
        : widget.employee.email;

    return AlertDialog(
      title: Row(
        children: [
          Expanded(child: Text('Oprávnění — $name')),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 8, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: _permissionCategories.entries.map((category) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 12, bottom: 4),
                  child: Text(
                    category.key.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMuted,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                ...category.value.entries.map((entry) {
                  final canGrant = widget.grantablePermissions == null ||
                      widget.grantablePermissions!.contains(entry.key);
                  return CheckboxListTile(
                    title: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14,
                        color: canGrant ? null : AppColors.textMuted,
                      ),
                    ),
                    value: _selected.contains(entry.key),
                    activeColor: AppColors.primary,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: canGrant
                        ? (checked) {
                            setState(() {
                              if (checked == true) {
                                _selected.add(entry.key);
                              } else {
                                _selected.remove(entry.key);
                              }
                            });
                          }
                        : null,
                  );
                }),
              ],
            );
          }).toList(),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () {
            widget.onSave(_selected.toList());
            Navigator.pop(context);
          },
          child: const Text('Uložit'),
        ),
      ],
    );
  }
}
