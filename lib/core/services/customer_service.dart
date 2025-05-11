import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/customer_store.dart';
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
    String id,
    String name,
    String email,
    String identification_number,
    String store_id_number,
    String store_address,
    String store_phone,
  ) async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "identification_number": identification_number,
        "store_id_number": store_id_number,
        "store_address": store_address,
        "store_phone": store_phone,
      }),
    );
    if (response.statusCode == 202) {
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

    ///Método para obtener todos los clientes por vendedor (customers)///
  Future<List<Customer>?> getCustomersBySeller(String id) async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers/seller/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List customers = data['customers'];
      return customers.map((json) => Customer.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar clientes: ${response.statusCode}');
    }
  }

  ///Método para obtener los clientes por Id(customers)///
  Future<CustomerWithStore> getCustomerById(String id) async {
    final url = Uri.parse('${AppConfig.apiBackCustomers}/customers/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CustomerWithStore.fromJson(data);
    } else {
      throw Exception('Error al cargar clientes: ${response.statusCode}');
    }
  }
}
