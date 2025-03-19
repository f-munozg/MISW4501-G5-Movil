import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Stock",
        showBackButton: false,
      ),
      body: Center(child: Text("Lista de stock")),
    );
  }
}