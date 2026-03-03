import 'package:flutter_test/flutter_test.dart';
import 'package:checkfood_client/security/domain/enums/user_role.dart';

void main() {
  group('My Restaurant menu visibility', () {
    test('isAtLeastManager returns true for OWNER', () {
      expect(UserRole.owner.isAtLeastManager, true);
    });

    test('isAtLeastManager returns true for MANAGER', () {
      expect(UserRole.manager.isAtLeastManager, true);
    });

    test('isAtLeastManager returns false for USER', () {
      expect(UserRole.user.isAtLeastManager, false);
    });

    test('isAtLeastManager returns false for EMPLOYEE', () {
      expect(UserRole.employee.isAtLeastManager, false);
    });

    test('UserRole.fromString parses OWNER correctly', () {
      expect(UserRole.fromString('OWNER'), UserRole.owner);
    });

    test('UserRole.fromString parses MANAGER correctly', () {
      expect(UserRole.fromString('MANAGER'), UserRole.manager);
    });

    test('UserRole.fromString defaults to user for unknown role', () {
      expect(UserRole.fromString('UNKNOWN'), UserRole.user);
    });
  });
}
