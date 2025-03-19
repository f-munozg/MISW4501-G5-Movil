import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Pedidos",
        showBackButton: false,
      ),
      body: Center(child: Text("Lista de pedidos")),
    );
  }
}