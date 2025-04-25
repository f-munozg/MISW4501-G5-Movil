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

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Order>.from(data.map((item) => Order.fromJson(item)));
    } else {
      throw Exception(
          'Error al cargar órdenes del cliente: ${response.statusCode}');
    }
  }

  /// Método para crear un pedido de reserva como cliente (Customer)///
  Future<String?> createReserveCustomer(
      String userId, List<CartItem> products) async {
    print(userId);
    print(products);
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/reserve');
    final productList = products
        .map((item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            })
        .toList();

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'products': productList,
      }),
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
    print(userId);
    print(sellerId);
    print(products);
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/order');
    final productList = products
        .map((item) => {
              'id': item.product.id,
              'quantity': item.quantity,
            })
        .toList();
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'seller_id': sellerId,
        'products': productList,
      }),
    );

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
}
