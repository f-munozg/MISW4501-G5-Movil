import 'package:ccp_mobile/features/clients/widgets/register_visit_form.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';


class RegisterVisitView extends StatelessWidget {
  const RegisterVisitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "Registrar visita",
        showBackButton: true,
      ),
      body: RegisterVisitForm(),
    );
  }
}