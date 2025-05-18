import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/core/utils/formatters.dart';
import 'package:ccp_mobile/features/orders/views/order_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/models/order.dart';

class ClientOrdersWidget extends StatelessWidget {
  final String clientId;
  final OrderService orderService;

    ClientOrdersWidget({
    super.key, 
    required this.clientId, 
    OrderService? orderService
  }) : orderService = orderService ?? OrderService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>?>(
      future: orderService.getOrdersByCustomerId(clientId),
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
              return _buildOrderRow(context, order);
            },
          );
        } else {
          return const Center(child: Text('No hay órdenes disponibles.'));
        }
      },
    );
  }

  Widget _buildOrderRow(BuildContext context, Order order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(formatDateTime(order.dateDelivery)),
        leading: const Icon(Icons.delivery_dining),
        contentPadding: const EdgeInsets.all(16),
        trailing: Text(parseStatus(order.status)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderConfirmationView(orderId: order.id),
            ),
          );
        },
      ),
    );
  }
}
