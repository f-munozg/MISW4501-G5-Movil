import 'dart:convert';

import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/widgets/custom_app_bar.dart';

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
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    final customerId = userData['user_id'];
    _ordersFuture = OrderService().getOrdersByCustomerId(customerId);
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
              return ListTile(
                title: Text(order.id),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ,
                  //   ),
                  // );
                },
              );
            },
          );
        },
      ),
    );
  }
}
