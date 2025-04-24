import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ProfileService {
  static const String _baseUrl = 'http://10.0.2.2:8080/api/users';

  static Future<Map<String, dynamic>?> getUserProfile() async {
    final token = await AuthService.getToken();
    print('🔑 Načítám token: $token');

    if (token == null) {
      print('❌ Token není dostupný.');
      return null;
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('🔁 Response: ${response.statusCode}');
    print('📦 Body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<bool> updateUserProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required int? age,
    required String profileImage,
  }) async {
    final token = await AuthService.getToken();
    if (token == null) return false;

    final response = await http.put(
      Uri.parse('$_baseUrl/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "age": age,
        "profileImage": profileImage,
      }),
    );

    return response.statusCode == 200;
  }
}
