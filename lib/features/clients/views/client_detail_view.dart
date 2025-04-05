import 'package:ccp_mobile/features/clients/views/client_visits_view.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/models/user.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/core/constants/app_colors.dart';


class ClientDetailView extends StatelessWidget {
  final User client;

  const ClientDetailView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
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
            _buildRow("Nombre:", client.name),
            _buildRow("Dirección:", client.address),
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
                  // Acción futura
                }),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const Text(
              "Ver sugerencias de compra",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
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
                  TextSpan(
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Últimas Órdenes:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildOrderRow("PEDIDO #12347"),
            _buildOrderRow("PEDIDO #12345"),
            _buildOrderRow("PEDIDO #12343"),
            _buildOrderRow("PEDIDO #12342"),
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

  Widget _buildOrderRow(String orderId) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(orderId),
          const Text(
            "Ver Detalle",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}