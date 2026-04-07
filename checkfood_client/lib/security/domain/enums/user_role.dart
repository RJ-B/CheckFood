/// Výčet rolí uživatele v systému.
///
/// Hierarchie oprávnění (od nejnižší): [user] < [employee] < [manager] < [owner] < [admin].
enum UserRole {
  user,
  employee,
  manager,
  owner,
  admin;

  static UserRole fromString(String? role) {
    switch (role?.toUpperCase()) {
      case 'ADMIN':
        return UserRole.admin;
      case 'OWNER':
        return UserRole.owner;
      case 'MANAGER':
        return UserRole.manager;
      case 'STAFF':
      case 'EMPLOYEE':
        return UserRole.employee;
      default:
        return UserRole.user;
    }
  }

  bool get isAtLeastEmployee => this != UserRole.user;
  bool get isAtLeastManager =>
      this == UserRole.manager || this == UserRole.owner || this == UserRole.admin;
}
