import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/orders/views/order_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cart_provider.dart';

class CheckoutView extends StatefulWidget {
  final orderService = OrderService();
  final String? orderId;
  CheckoutView({super.key, required this.orderId});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? userRole;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  @override
  void dispose() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    cart.clearCart();
    super.dispose();
  }

  // Cargar usuario desde el almacenamiento local
  Future<void> _loadUserRole() async {
    final box = GetStorage();
    setState(() {
      userRole = jsonDecode(box.read('user_data') ?? '{}')['role'];
    });
  }

  // Crear pedido
  Future<bool> _handleCreateOrder() async {
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    final userId = userData['user_id'];
    final orderId = widget.orderId ?? '';

    final success = await widget.orderService.createOrder(orderId, userId);

    setState(() => _isLoading = false);

    return success;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final double total = cart.items.fold(
      0.0,
      (sum, item) => sum + item.product.unitValue * item.quantity,
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: "Checkout",
        showBackButton: true,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("No hay productos en el carrito"))
          : ListView.builder(
              itemCount: cart.items.length,
              padding: const EdgeInsets.only(bottom: 140),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: _getImage(item.product.photo),
                  ),
                  title: Text(item.product.product),
                  subtitle: Text("Cantidad: ${item.quantity}"),
                  trailing: Text(
                      "\$${(item.product.unitValue * item.quantity).toStringAsFixed(2)}"),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Text("Cliente: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(cart.selectedClient ?? "No seleccionado"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text("Total: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          cart.clearCart();
                          final response = await _handleCreateOrder();
                          if (response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Pedido creado exitosamente")),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderConfirmationView(
                                  orderId: widget.orderId ?? '',
                                ),
                              ),
                              (route) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Error al crear el pedido")),
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
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Crear pedido"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _getImage(String base64String) {
    try {
      final imageBytes = base64Decode(base64String);
      return Image.memory(imageBytes, fit: BoxFit.cover);
    } catch (e) {
      return const Icon(Icons.image, size: 50, color: Colors.grey);
    }
  }
}
