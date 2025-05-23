import 'dart:convert';

import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:ccp_mobile/core/models/order.dart';
import 'package:http/http.dart' as http;

class OrderService {
  /// Método para obtener todos los pedidos de un cliente (orders) ///
  Future<List<Order>?> getOrdersByCustomerId(String id) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/user/$id');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final dataList = data['orders'] as List;
      return List<Order>.from(dataList.map((item) => Order.fromJson(item)));
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception(
          'Error al cargar órdenes del cliente: ${response.statusCode}');
    }
  }

  /// Método para crear un pedido de reserva como cliente (Customer)///
  Future<String?> createReserveCustomer(
      String userId, List<CartItem> products) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/reserve');
    final productList = products
        .map((item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            })
        .toList();

    final body = jsonEncode({
      'user_id': userId,
      'products': productList,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final orderId = jsonDecode(response.body)['id'];
      return orderId;
    } else {
      return null;
    }
  }

  /// Método para crear un pedido de reserva como vendedor (Seller)///
  Future<String?> createReserveSeller(
      String userId, String sellerId, List<CartItem> products) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/reserve');
    final productList = products
        .map((item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            })
        .toList();
    final body = jsonEncode({
      'user_id': userId,
      'products': productList,
    });
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final orderId = jsonDecode(response.body)['id'];
      return orderId;
    } else {
      return null;
    }
  }

  /// Crear un pedido
  Future<bool> createOrder(String orderId, String userId) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/order');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'order_id': orderId,
        'user_id': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  /// Método para obtener un pedido por ID ///
  Future<Order?> getOrdersById(String id) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/$id');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Order.fromJson(data['order']);
    } else {
      throw Exception('Error la órden: ${response.statusCode}');
    }
  }

  /// Método para obtener detalle de un pedido por ID ///
  Future<List<dynamic>> getOrdersDetailById(String id) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/$id/detail');
    final response = await http.get(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final dataList = data['products'] as List<dynamic>;
      return dataList; // Devuelves el JSON crudo sin mapear ni castear nada
    } else {
      throw Exception(
          'Error al obtener detalle del pedido: ${response.statusCode}');
    }
  }

  Future<bool> createEvent({
    required String name,
    required String startDate,
    required String endDate,
    required String location,
  }) async {
    final url = Uri.parse('${AppConfig.apiBackSellers}/sellers/log_event');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
        'location': location,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
