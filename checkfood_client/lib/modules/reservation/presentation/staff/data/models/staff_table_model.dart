import '../../domain/entities/staff_table.dart';

/// API response model pro stůl vrácený endpointem stolů personálu.
class StaffTableModel {
  final String id;
  final String label;
  final int capacity;
  final bool active;

  const StaffTableModel({
    required this.id,
    required this.label,
    required this.capacity,
    required this.active,
  });

  factory StaffTableModel.fromJson(Map<String, dynamic> json) {
    return StaffTableModel(
      id: json['id'] as String,
      label: json['label'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      active: json['active'] as bool? ?? true,
    );
  }

  StaffTable toEntity() {
    return StaffTable(id: id, label: label, capacity: capacity, active: active);
  }
}
