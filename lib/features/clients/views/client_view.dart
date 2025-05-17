import 'dart:convert';

import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/views/client_detail_view.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  late Future<List<Customer>?> _clientsFuture;

  @override
  void initState() {
    super.initState();
      final box = GetStorage();
      final userData = jsonDecode(box.read('user_data') ?? '{}');
      final sellerId =  userData['seller_id'] ?? '';
    _clientsFuture = CustomerService().getCustomersBySeller(sellerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Clientes",
        showBackButton: false,
      ),
      body: FutureBuilder<List<Customer>?>(
        future: _clientsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay clientes disponibles"));
          }

          final clients = snapshot.data!;

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return ListTile(
                leading: CircleAvatar(child: Text(client.name?.isNotEmpty == true ? client.name![0] : '?')),
                title: Text(client.name ?? 'Nombre no disponible'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClientDetailView(client: client),
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
