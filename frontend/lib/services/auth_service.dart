import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/auth';
  static const _storage = FlutterSecureStorage();

  static Future<bool> register({
    required String name,
    required String surname,
    required String email,
    required String phone,
    required int? age,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('$_baseUrl/register');
    final body = {
      "firstName": name,
      "lastName": surname,
      "email": email,
      "phone": phone,
      "age": age,
      "username": username,
      "password": password,
    };

    print('Odesílám data k registraci: $body');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>?> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['token'];

      if (token != null) {
        await _storage.write(key: 'jwt', value: token);
        await _storage.write(key: 'firstName', value: body['firstName']);
        await _storage.write(key: 'lastName', value: body['lastName']);
        await _storage.write(key: 'email', value: body['email']);
        return body;
      }
    }

    return null;
  }

  static Future<void> logout() async {
    await _storage.deleteAll();
  }

  static Future<String?> getToken() async => await _storage.read(key: 'jwt');

  static Future<bool> isLoggedIn() async => (await getToken()) != null;

  static Future<String?> getFirstName() async =>
      await _storage.read(key: 'firstName');
  static Future<String?> getLastName() async =>
      await _storage.read(key: 'lastName');
  static Future<String?> getEmail() async => await _storage.read(key: 'email');
}
