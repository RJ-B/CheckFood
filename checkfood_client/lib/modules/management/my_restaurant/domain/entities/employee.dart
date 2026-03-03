class Employee {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String role;
  final DateTime? createdAt;

  const Employee({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.createdAt,
  });

  bool get isOwner => role == 'OWNER';
  bool get isManager => role == 'MANAGER';
  bool get isStaff => role == 'STAFF';
}
