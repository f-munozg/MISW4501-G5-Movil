import 'package:ccp_mobile/features/pqrs/widgets/pqrs_form.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';



class PqrsCreateView extends StatelessWidget {
  const PqrsCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Registrar visita",
        showBackButton: true,
      ),
      body: PqrsCreateForm(
        detailController: TextEditingController(),
        onSubmit: () {
          // Add your submission logic here
        },
      ),
    );
  }
}