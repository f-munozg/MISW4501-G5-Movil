import 'package:http/http.dart' as http;
import '../constants/app_config.dart';

class LoginService {
  Future<bool> login(String username, String password) async {
    final response =
        await http.post(Uri.parse('${AppConfig.apiBack}/user/login').replace(
      queryParameters: {
        'username': username,
        'password': password,
      },
    ));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw Exception('Error de servidor: ${response.statusCode}');
    }
  }
}
