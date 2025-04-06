import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  ///Método para registrar un nuevo cliente (customer)///
  Future<bool> registerCustomer(
      String username, String email, String password) async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers/customer');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

    ///Método para registrar un nuevo cliente (customer)///
  Future<bool> updateCustomer(
      String username, String email, String password) async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers/customer');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }



  ///Método para obtener todos los clientes (customers)///
  Future<List<Customer>?> getCustomers() async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List customers = data['customers'];
      return customers.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar clientes: ${response.statusCode}');
    }
  }
}
