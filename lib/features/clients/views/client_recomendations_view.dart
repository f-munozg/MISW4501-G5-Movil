import 'package:ccp_mobile/core/models/customer.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientRecomendationsView extends StatelessWidget {
  final Customer client;

  ClientRecomendationsView({super.key, required this.client});

final productos = List.generate(4, (index) => 'Lorem Ipsum');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: "Detalle de pedido",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Sugerencias de Compra:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            ),
            const SizedBox(height: 16),
            ...productos.map((p) => _productoItem()).toList(),
            const SizedBox(height: 24),
            const Text(
              'Sugerencias de Ubicación:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.image, size: 50)),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _productoItem() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Lorem Ipsum", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text("Fabricante: XXX"),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Cantidad: XXX"),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFF00695C),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 24, thickness: 1),
      ],
    );
  }
}

