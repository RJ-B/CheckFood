import '../../../domain/entities/employee.dart';

/// API response model pro zaměstnance restaurace.
class EmployeeResponseModel {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String role;
  final List<String> permissions;
  final String? createdAt;

  const EmployeeResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.permissions = const [],
    this.createdAt,
  });

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    return EmployeeResponseModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? 'STAFF',
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      createdAt: json['createdAt'] as String?,
    );
  }

  Employee toEntity() => Employee(
        id: id,
        userId: userId,
        name: name,
        email: email,
        role: role,
        permissions: permissions,
        createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      );
}
