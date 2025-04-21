import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl =
      'http://10.0.2.2:8080/api/auth'; // změň IP, pokud nejsi v emulatoru
  static const _storage = FlutterSecureStorage();

  static Future<bool> register({
    required String name,
    required String surname,
    required String email,
    required String phone,
    required int? age,
    required String role,
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
      "role": role,
      "username": username,
      "password": password,
    };

    try {
      print(" Posílám data: ${jsonEncode(body)}");
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print(" Status code: ${response.statusCode}");
      print(" Odpověď těla: ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print(" Chyba při registraci: $e");
      return false;
    }
  }

  /// Přihlášení uživatele – pošle username + password a uloží JWT token
  static Future<bool> login(String username, String password) async {
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
        return true;
      }
    }

    return false;
  }

  /// Odhlášení uživatele – smaže token
  static Future<void> logout() async {
    await _storage.delete(key: 'jwt');
  }

  /// Získání aktuálního JWT tokenu
  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  /// Zjištění, zda je uživatel přihlášen (token existuje)
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
