import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:http/http.dart' as http;


class LoginService {
  Future<String?> login(String username, String password) async {
    final url = Uri.parse('${AppConfig.apiBackUser}/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['role'];
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Error de servidor: ${response.statusCode}');
    }
  }
}
