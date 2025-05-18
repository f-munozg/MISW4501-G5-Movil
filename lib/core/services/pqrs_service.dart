import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/pqrs.dart';
import 'package:http/http.dart' as http;

class PqrsService {
  // Métdodo para crear un PQRS como cliente (Customer)
  Future<bool?> createPqrs(String title, String description, String orderId,
      String customerId) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/pqrs/addPQRS');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'type': 'peticion',
        'title': title,
        'description': description,
        'order_id': orderId,
        'customer_id': customerId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data);
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw Exception('Error de servidor: ${response.statusCode}');
    }
  }

  // Método para obtener todos los PQRS de un cliente
  Future<List<Pqrs>?> getPqrsByCustomerId(String customerId) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/pqrs/getCustomer')
        .replace(queryParameters: {'customer_id': customerId});

    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print(data);
      final dataList = data['pqrs'] as List;
      return List<Pqrs>.from(dataList.map((item) => Pqrs.fromJson(item)));
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(
          'Error al cargar órdenes del cliente: ${response.statusCode}');
    }
  }

  // Actualizar el estado de un PQRS
  Future<bool?> updatePqrs({
  required String pqrsId,
  required String status,
  required String orderId,
}) async {
  final url = Uri.parse('${AppConfig.apiBackOrders}/orders/pqrs/updatePQRS/$pqrsId');
  print('pqrsId: $pqrsId');
  print('status: $status');
  print('orderId: $orderId');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'status': status,
      'order_id': orderId,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 204) {
    final data = jsonDecode(response.body);
    print('PQRS actualizada: $data');
    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    throw Exception('Error al actualizar PQRS: ${response.statusCode}');
  }
}

}
