import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:get_storage/get_storage.dart';
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final box = GetStorage();
      await box.write('user_data', jsonEncode(data));
      return data['role'];
    } else if (response.statusCode == 401) {
      return null;
    } else {
      throw Exception('Error de servidor: ${response.statusCode}');
    }
  }
}
