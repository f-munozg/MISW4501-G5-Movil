import 'package:ccp_mobile/core/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ccp_mobile/core/models/order.dart'; // Asegúrate de que el modelo Order esté bien definido

class ClientOrdersWidget extends StatelessWidget {
  final String clientId;

  const ClientOrdersWidget({super.key, required this.clientId});

  Future<List<Order>?> _getOrders(String id) async {
    final url = Uri.parse('${AppConfig.apiBackOrders}/orders/user/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Order>.from(data.map((item) => Order.fromJson(item)));
    } else {
      throw Exception('Error al cargar órdenes del cliente: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>?>(
      future: _getOrders(clientId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderRow(order);
            },
          );
        } else {
          return const Center(child: Text('No hay órdenes disponibles.'));
        }
      },
    );
  }

  Widget _buildOrderRow(Order order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text("PEDIDO ${order.id}"),
        subtitle: Text("Fecha: ${order.dateOrder}"),
        trailing: Text("Estado: \$${order.status}"),
        onTap: () {
          // Agregar la acción al tap si es necesario
        },
      ),
    );
  }
}