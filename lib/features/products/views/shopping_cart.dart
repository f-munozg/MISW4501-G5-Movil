import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:ccp_mobile/core/constants/app_roles.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/products/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cart_provider.dart';

class ShoppingCartView extends StatelessWidget {
  ShoppingCartView({super.key});
  final orderService = OrderService();

  Future<String?> _getUserRole() async {
    final box = GetStorage();
    final data = box.read('user_data');
    if (data == null) return null;

    final decoded = jsonDecode(data);
    return decoded['role'] as String?;
  }

  Future<String?> _getUserId() async {
    final box = GetStorage();
    final data = box.read('user_data');
    if (data == null) return null;

    final decoded = jsonDecode(data);
    return decoded['user_id'] as String?;
  }

  Future<List<Customer>> _fetchCustomers() async {
    final customerService = CustomerService();
    return await customerService.getCustomers() ?? [];
  }

  Future<String?> _handleReservation(BuildContext context) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userRole = await _getUserRole();

    if (userRole == AppRoles.client) {
      final userId = await _getUserId();
      final success = await OrderService().createReserveCustomer(
        userId ?? '',
        cartProvider.items,
      );
      if (success == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No se pudo reservar el pedido")),
        );
      }

      return success;
    } else {
      print("Usuario es vendedor: $userRole");
      final userId = cartProvider.selectedClient;
      print("Usuario es vendedor: $userId");
      final sellerId = await _getUserId();
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Selecciona un cliente antes de continuar")),
        );
        return null;
      }
      final success = await OrderService().createReserveSeller(
        userId,
        sellerId ?? '',
        cartProvider.items,
      );

      if (success == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No se pudo reservar el pedido")),
        );
      }

      return success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Carrito",
        showBackButton: true,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Tu carrito está vacío"))
          : ListView.builder(
              itemCount: cart.items.length,
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: _getImage(item.product.photo), // Aquí manejamos la foto
                  ),
                  title: Text(item.product.product),
                  subtitle: Text("Cantidad: ${item.quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "\$${(item.product.unitValue * item.quantity).toStringAsFixed(2)}"),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => cart.removeProduct(item.product),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : FutureBuilder<String?>(
              future: _getUserRole(),
              builder: (context, snapshot) {
                final userRole = snapshot.data;

                return SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, -2)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (userRole != AppRoles.client)
                          FutureBuilder<List<Customer>>(
                            future: _fetchCustomers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text(
                                    "No hay clientes disponibles.");
                              } else {
                                final customers = snapshot.data!;
                                return DropdownButton<String>(
                                  hint: const Text("Selecciona un cliente"),
                                  isExpanded: true,
                                  value: cart.selectedClient,
                                  items: customers
                                      .map((customer) =>
                                          DropdownMenuItem<String>(
                                            value: customer.userId,
                                            child: Text(
                                                customer.name ?? 'Cliente'),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      cart.setClient(value);
                                    }
                                  },
                                );
                              }
                            },
                          )
                        else ...[
                          FutureBuilder<String?>(
                            future: _getUserId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              } else if (snapshot.hasData) {
                                cart.setClient(snapshot.data!);
                                return const SizedBox.shrink();
                              } else {
                                return const Text(
                                    "No se pudo obtener el usuario.");
                              }
                            },
                          ),
                        ],
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => const Center(
                                    child: CircularProgressIndicator()),
                              );
                              final success = await _handleReservation(context);
                              Navigator.pop(context);
                              if (success != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CheckoutView(orderId: success)),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                  color: AppColors.primaryColor, width: 2),
                              foregroundColor: AppColors.primaryColor,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Reservar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _getImage(String base64String) {
    try {
      final imageBytes = base64Decode(base64String);
      return Image.memory(imageBytes, fit: BoxFit.cover);
    } catch (e) {
      return const Icon(Icons.image, size: 50, color: Colors.grey); // Fallback si la imagen es inválida
    }
  }
}