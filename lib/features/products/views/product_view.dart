import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Productos",
        showBackButton: false,
      ),
      body: Center(child: Text("Lista de productos")),
    );
  }
}