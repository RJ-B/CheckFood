enum UserRole {
  user,
  employee,
  manager,
  owner;

  static UserRole fromString(String? role) {
    switch (role?.toUpperCase()) {
      case 'OWNER':
        return UserRole.owner;
      case 'MANAGER':
        return UserRole.manager;
      case 'EMPLOYEE':
        return UserRole.employee;
      default:
        return UserRole.user;
    }
  }

  bool get isAtLeastEmployee => this != UserRole.user;
  bool get isAtLeastManager =>
      this == UserRole.manager || this == UserRole.owner;
}
