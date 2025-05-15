import 'dart:convert';
import 'dart:io';

import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/core/utils/formatters.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/orders/views/order_confirmation_view.dart';
import 'package:ccp_mobile/features/orders/views/order_detail_product_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class OrderDetailView extends StatefulWidget {
  final String orderId; // <-- Recibe ID de la orden

  const OrderDetailView({super.key, required this.orderId});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  final orderService = OrderService();
  Order? order;
  bool isLoading = true;
  File? selectedImage; // <-- Para almacenar la imagen seleccionada

  @override
  void initState() {
    super.initState();
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    try {
      final fetchedOrder = await orderService.getOrdersById(widget.orderId);
      setState(() {
        order = fetchedOrder;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar pedido: $e')),
      );
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<bool> _handleCreateOrder(orderId) async {
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    final userId = userData['user_id'];
    final result = await orderService.createOrder(orderId, userId);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Detalle de pedido",
        showBackButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (order == null) ...[
                        const Text(
                          'No se encontró el pedido',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                      ] else ...[
                        Text(
                          'PEDIDO #${order!.id}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Ítems: "),
                            SizedBox(width: 24),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailProductView(
                                                orderId: order!.id)));
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    "Ver Detalle ",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Icon(Icons.open_in_new, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Fecha Pedido: "),
                            Text(formatDateTime(order!.dateOrder)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Fecha Entrega: "),
                            Text(formatDateTime(order!.dateDelivery)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Estado: "),
                            Text(parseStatus(order!.status)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        OutlinedButton(
                          onPressed: pickImage,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            foregroundColor: const Color(0xFF2E7055),
                            side: const BorderSide(
                                color: Color(0xFF2E7055), width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Cargar comprobante de pago"),
                        ),
                        const SizedBox(height: 16),
                        if (selectedImage != null)
                          Image.file(
                            selectedImage!,
                            height: 200,
                          ),
                        OutlinedButton.icon(
                          onPressed: () {
                            // TODO: seguir pedido
                          },
                          icon: const Icon(Icons.map),
                          label: const Text("Seguir pedido"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 14),
                            foregroundColor: const Color(0xFF2E7055),
                            side: const BorderSide(
                                color: Color(0xFF2E7055), width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 84),
                        if (parseStatus(order!.status).toLowerCase() ==
                            'reservado') ...[
                          OutlinedButton(
                            onPressed: () async {
                              cart.clearCart();
                              final response =
                                  await _handleCreateOrder(order!.id);

                              if (response) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Pedido creado exitosamente")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Error al crear el pedido")),
                                );
                              }
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderConfirmationView(orderId: order!.id),
                                ),
                                (route) => false,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              foregroundColor: const Color(0xFF2E7055),
                              side: const BorderSide(
                                  color: Color(0xFF2E7055), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Realizar pedido"),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
