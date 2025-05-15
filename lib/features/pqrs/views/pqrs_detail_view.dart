import 'package:ccp_mobile/core/models/pqrs.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PqrsDetailView extends StatelessWidget {
  final Pqrs pqrs;

  const PqrsDetailView({super.key, required this.pqrs});

  @override
  Widget build(BuildContext context) {
    // Datos simulados
    const orderId = '#12345';
    const orderDate = '25/03/2025';
    const deliveryDate = '25/03/2025';
    const refund = '\$850.402';
    const observation = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalle PQRS',
        showBackButton: true,
        ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B37A), Color(0xFF8CD790)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text('PEDIDO $orderId',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  const SizedBox(height: 12),
                  Center(child: Text('Fecha Pedido: $orderDate')),
                  Center(child: Text('Fecha Entrega: $deliveryDate')),
                  const SizedBox(height: 24),
                  Center(
                      child: Text('PQR $orderId',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))),
                  const SizedBox(height: 8),
                  Center(
                      child: Text('Saldo a Reembolsar: $refund',
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 16),
                  const Text('Observaciones:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(observation, textAlign: TextAlign.justify),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Acción de responder
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00946E),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Responder',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // ajusta según navegación real
        selectedItemColor: const Color(0xFF00946E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
