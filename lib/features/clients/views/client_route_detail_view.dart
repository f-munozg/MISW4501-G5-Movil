import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ClientRouteDetailView extends StatelessWidget {
  const ClientRouteDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ruta',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Ruta más rápida:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  '15 minutos',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
