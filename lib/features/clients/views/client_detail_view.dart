import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/views/client_recomendations_view.dart';
import 'package:ccp_mobile/features/clients/views/client_visits_view.dart';
import 'package:ccp_mobile/features/clients/widgets/client_orders_widget.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_view.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/core/constants/app_colors.dart';

class ClientDetailView extends StatelessWidget {
  final Customer client;

  const ClientDetailView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    print("Client: ${client.id}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Cliente",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Text(
                "CLIENTE # ${client.identificationNumber}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildRow("Nombre:", client.name ?? "N/A"),
            _buildRow("Dirección:", "Calle 123 #45-67"),
            _buildRow("Teléfono:", "123456789"),
            _buildRow("Zona:", "Centro"),
            _buildRow("Última Visita:", "25/03/2025"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _roundedOutlinedButton("Visitas", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClientVisitsView(client: client),
                    ),
                  );
                }),
                _roundedOutlinedButton("PQRS", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PqrsView(client: client),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientRecomendationsView(client: client),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(width: 8),
                  Text(
                    "Ver sugerencias de compra",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Observaciones: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), 
            Container(
              width: double
                  .infinity, 
              height: 50, 
              alignment: Alignment
                  .center, 
              child: const Text(
                "Sin observaciones",
                textAlign:
                    TextAlign.center, 
                style: TextStyle(fontSize: 12), 
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Últimas Órdenes:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height:
                  300, // Ajusta la altura según cuántas órdenes quieras mostrar
              child: ClientOrdersWidget(clientId: client.userId),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _roundedOutlinedButton(String label, VoidCallback onTap) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
