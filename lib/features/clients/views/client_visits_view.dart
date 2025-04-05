import 'package:ccp_mobile/features/clients/views/register_visit_view.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/models/user.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/core/constants/app_colors.dart';

class ClientVisitsView extends StatelessWidget {
  final User client;

  const ClientVisitsView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    // Visitas mockeadas
    final visits = [
      {"date": "25/03/2025"},
      {"date": "20/03/2025"},
      {"date": "15/03/2025"},
      {"date": "07/03/2025"},
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Visitas",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.map),
                    SizedBox(width: 8),
                    Text("Ver Ruta",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterVisitView(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryColor),
                    foregroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Crear visita",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...visits
                .map((visit) => _visitItem(client, visit["date"]!))
                .toList(),
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            const Center(
              child: Text("RUTA SUGERIDA",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text("Tiempo Optimizado:   20 minutos",
                  style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 16),
            _visitItem(client, "07/03/2025"),
          ],
        ),
      ),
    );
  }

  Widget _visitItem(User client, String date) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(client.name,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(client.address),
                ],
              ),
            ),
            Text(date),
            const SizedBox(width: 12),
            const Icon(Icons.remove_red_eye, color: AppColors.primaryColor),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1),
      ],
    );
  }
}
