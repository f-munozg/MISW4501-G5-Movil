import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_create_view.dart';
import 'package:flutter/material.dart';

class OrderDetailProductView extends StatefulWidget {
  final List<dynamic> cartItems;
  final bool canCreatePqrs;
  final String orderId;
  final String customerId;

  const OrderDetailProductView({
    super.key,
    required this.cartItems,
    required this.canCreatePqrs,
    required this.orderId,
    required this.customerId,
  });

  @override
  _OrderDetailProductViewState createState() => _OrderDetailProductViewState();
}

class _OrderDetailProductViewState extends State<OrderDetailProductView> {
  final productos = List.generate(4, (index) => 'Lorem Ipsum');

  @override
  Widget build(BuildContext context) {
    print("Cart items: ${widget.cartItems}");
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detalle de pedido",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            ...widget.cartItems.map(_productoItem).toList(),
            if (widget.canCreatePqrs) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PqrsCreateView(orderId: widget.orderId,customerId: widget.customerId,)),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  foregroundColor: const Color(0xFF2E7055),
                  side: const BorderSide(color: Color(0xFF2E7055), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Crear PQRS"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _productoItem(dynamic item) {
    // item tiene 'quantity' y 'product'
    final quantity = item['quantity'];
    final product = item['product'] ?? {};

    // product es Map o dynamic, obtenemos campos dinámicos:
    final productName = product['name'] ?? 'Sin nombre';
    final category = product['category'] ?? 'Sin categoría';

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("Categoría: $category", style: TextStyle(fontSize: 10),),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Cantidad: $quantity"),
              ],
            ),
          ],
        ),
        const Divider(height: 24, thickness: 1),
      ],
    );
  }
}
