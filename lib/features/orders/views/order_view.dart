import 'dart:convert';

import 'package:ccp_mobile/core/constants/app_formats.dart';
import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/features/orders/views/order_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/core/utils/formatters.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  late Future<List<Order>?> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadOrders();
  }

  void _loadOrders() {
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    final customerId = userData['user_id'];

    setState(() {
      _ordersFuture = OrderService().getOrdersByCustomerId(customerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Pedidos",
        showBackButton: false,
      ),
      body: FutureBuilder<List<Order>?>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay órdenes realizadas"));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final isReservado = order.status == AppFormats.estadoReservado;

              return ListTile(
                leading: isReservado
                    ? const Icon(Icons.warning, color: Colors.redAccent)
                    : null,
                title: Text("Pedido ${formatDateTime(order.dateOrder)}"),
                subtitle: Text("Estado: ${parseStatus(order.status)}"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailView(orderId: order.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
