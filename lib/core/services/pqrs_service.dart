import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/pqrs.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PqrsService {
  // Métdodo para crear un PQRS como cliente (Customer)
  Future<String?> createPqrs(String username, String password) async {
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

  // Método para obtener todos los PQRS de un cliente
  Future<List<Pqrs>?> getPqrsByCustomerId(String id) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/user/$id');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final dataList = data['orders'] as List;
      return List<Pqrs>.from(dataList.map((item) => Pqrs.fromJson(item)));
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(
          'Error al cargar órdenes del cliente: ${response.statusCode}');
    }
  }
}
