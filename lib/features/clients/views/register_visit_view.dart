import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/widgets/register_visit_form.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';


class RegisterVisitView extends StatelessWidget {
  final Customer client;
  const RegisterVisitView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    print("Cliente: ${client.id}");
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Registrar visita",
        showBackButton: true,
      ),
      body: RegisterVisitForm(client: client),
    );
  }
}