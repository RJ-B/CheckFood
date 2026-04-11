import 'package:flutter_test/flutter_test.dart';

import 'package:checkfood_client/security/validators/auth_validators.dart';
import 'package:checkfood_client/security/validators/password_validator.dart';

void main() {
  group('AuthValidators.validateEmail', () {
    test('should return error for null input', () {
      expect(AuthValidators.validateEmail(null), isNotNull);
    });

    test('should return error for empty string', () {
      expect(AuthValidators.validateEmail(''), isNotNull);
    });

    test('should return error for missing @', () {
      expect(AuthValidators.validateEmail('userexample.com'), isNotNull);
    });

    test('should return error for missing domain', () {
      expect(AuthValidators.validateEmail('user@'), isNotNull);
    });

    test('should return error for missing TLD', () {
      expect(AuthValidators.validateEmail('user@example'), isNotNull);
    });

    test('should return null for valid email', () {
      expect(AuthValidators.validateEmail('user@example.com'), isNull);
    });

    test('should return null for email with subdomain', () {
      expect(AuthValidators.validateEmail('user@mail.example.co.uk'), isNull);
    });

    test('should return null for email with dots before @', () {
      expect(AuthValidators.validateEmail('first.last@example.com'), isNull);
    });

    // EXPECTED-FAIL: auth_validators — production code does not yet reject
    // emails with consecutive dots (e.g. user..name@example.com) which are
    // invalid per RFC 5321.
    test('should return error for email with consecutive dots', () {
      expect(
        AuthValidators.validateEmail('user..name@example.com'),
        isNotNull,
        reason: 'consecutive dots in local part are invalid per RFC 5321',
      );
    });
  });

  group('AuthValidators.validatePassword', () {
    test('should return error for null', () {
      expect(AuthValidators.validatePassword(null), isNotNull);
    });

    test('should return error for empty string', () {
      expect(AuthValidators.validatePassword(''), isNotNull);
    });

    test('should return error for password shorter than 8 chars', () {
      expect(AuthValidators.validatePassword('Ab1!'), isNotNull);
    });

    test('should return null for valid 8-char password', () {
      expect(AuthValidators.validatePassword('password'), isNull);
    });
  });

  group('AuthValidators.validateRequired', () {
    test('should return error for null', () {
      expect(AuthValidators.validateRequired(null, 'Name'), isNotNull);
    });

    test('should return error for whitespace-only string', () {
      expect(AuthValidators.validateRequired('   ', 'Name'), isNotNull);
    });

    test('should return null for non-empty string', () {
      expect(AuthValidators.validateRequired('Jan', 'Name'), isNull);
    });
  });

  group('AuthValidators.validateConfirmPassword', () {
    test('should return error for null', () {
      expect(
        AuthValidators.validateConfirmPassword(null, 'Password1!'),
        isNotNull,
      );
    });

    test('should return error when passwords do not match', () {
      expect(
        AuthValidators.validateConfirmPassword('Different1!', 'Password1!'),
        isNotNull,
      );
    });

    test('should return null when passwords match', () {
      expect(
        AuthValidators.validateConfirmPassword('Password1!', 'Password1!'),
        isNull,
      );
    });
  });

  group('PasswordValidator.validate', () {
    test('should return error for null', () {
      expect(PasswordValidator.validate(null), isNotNull);
    });

    test('should return error for empty string', () {
      expect(PasswordValidator.validate(''), isNotNull);
    });

    test('should return error when shorter than 8 chars', () {
      expect(PasswordValidator.validate('Ab1!'), isNotNull);
    });

    test('should return error when longer than 64 chars', () {
      final long = 'Aa1!' * 17; // 68 chars
      expect(PasswordValidator.validate(long), isNotNull);
    });

    test('should return error when missing uppercase', () {
      expect(PasswordValidator.validate('password1!'), isNotNull);
    });

    test('should return error when missing lowercase', () {
      expect(PasswordValidator.validate('PASSWORD1!'), isNotNull);
    });

    test('should return error when missing digit', () {
      expect(PasswordValidator.validate('Password!'), isNotNull);
    });

    test('should return error when missing special char', () {
      expect(PasswordValidator.validate('Password1'), isNotNull);
    });

    test('should return null for valid complex password', () {
      expect(PasswordValidator.validate('Password1!'), isNull);
    });

    test('should return null for exactly 8-char valid password', () {
      expect(PasswordValidator.validate('Abcdef1!'), isNull);
    });

    test('should accept all defined special chars', () {
      for (final ch in ['@', r'$', '!', '%', '*', '?', '&']) {
        expect(
          PasswordValidator.validate('Password1$ch'),
          isNull,
          reason: 'char "$ch" should be accepted',
        );
      }
    });
  });

  group('PasswordValidator.validateMatch', () {
    test('should return error for null confirm', () {
      expect(PasswordValidator.validateMatch(null, 'Password1!'), isNotNull);
    });

    test('should return error when passwords differ', () {
      expect(
        PasswordValidator.validateMatch('Other1!', 'Password1!'),
        isNotNull,
      );
    });

    test('should return null when passwords match', () {
      expect(
        PasswordValidator.validateMatch('Password1!', 'Password1!'),
        isNull,
      );
    });

    test('should return error for empty confirmation', () {
      expect(PasswordValidator.validateMatch('', 'Password1!'), isNotNull);
    });
  });

  // Additional email edge cases
  group('AuthValidators.validateEmail — extra edge cases', () {
    test('should return error for leading space', () {
      expect(AuthValidators.validateEmail(' user@example.com'), isNotNull);
    });

    test('should return error for trailing space', () {
      expect(AuthValidators.validateEmail('user@example.com '), isNotNull);
    });

    test('should return error for double @', () {
      expect(AuthValidators.validateEmail('user@@example.com'), isNotNull);
    });

    test('should return error for only spaces', () {
      expect(AuthValidators.validateEmail('   '), isNotNull);
    });

    test('should return error for single-char TLD', () {
      expect(AuthValidators.validateEmail('user@example.c'), isNotNull);
    });

    // EXPECTED-FAIL: auth_validators — regex does not allow '+' in local part
    // (user+tag@example.com is valid per RFC 5321)
    test('should return null for email with plus addressing', () {
      expect(
        AuthValidators.validateEmail('user+tag@example.com'),
        isNull,
        reason: 'plus addressing is valid per RFC 5321',
      );
    });
  });

  // AuthValidators.validatePassword — extra
  group('AuthValidators.validatePassword — extra edge cases', () {
    test('should return null for exactly 8 chars', () {
      expect(AuthValidators.validatePassword('12345678'), isNull);
    });

    test('should return error for 7 chars', () {
      expect(AuthValidators.validatePassword('1234567'), isNotNull);
    });
  });
}
