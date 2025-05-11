import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientRecomendationsView extends StatelessWidget {
  const ClientRecomendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Recomendaciones ubicación y venta",
        showBackButton: false,
      ),
      body: Center(child: Text("Recomndaciones del cliente")),
    );
  }
}