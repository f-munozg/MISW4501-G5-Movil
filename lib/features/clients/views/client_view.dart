import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientView extends StatelessWidget {
  const ClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Clientes",
        showBackButton: false,
      ),
      body: Center(child: Text("Lista de Clientes")),
    );
  }
}