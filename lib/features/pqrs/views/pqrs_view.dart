import 'package:ccp_mobile/core/models/customer.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class PqrsView extends StatelessWidget {
  final Customer client;

  const PqrsView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PQRS",
        showBackButton: true,
      ),
      body: Center(child: Text("Lista de PQRS cliente ${client.name}")),
    );
  }
}