/// Zaměstnanec restaurace s jeho rolí a volitelnými granulárními oprávněními.
class Employee {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String role;
  final List<String> permissions;
  final DateTime? createdAt;

  const Employee({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.permissions = const [],
    this.createdAt,
  });

  bool get isOwner => role == 'OWNER';
  bool get isManager => role == 'MANAGER';
  bool get isStaff => role == 'STAFF';
  bool get isHost => role == 'HOST';

  bool hasPermission(String permission) => isOwner || permissions.contains(permission);
}
