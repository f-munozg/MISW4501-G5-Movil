import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Tiendas",
        showBackButton: false,
      ),
      body: Center(child: Text("Lista de tiendas")),
    );
  }
}