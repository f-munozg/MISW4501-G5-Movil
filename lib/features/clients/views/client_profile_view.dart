import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../widgets/client_profile_form.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _documentController = TextEditingController();
    final _nitController = TextEditingController();
    final _addressController = TextEditingController();
    final _phoneController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Mis datos",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClientProfileForm(
          formKey: _formKey,
          nameController: _nameController,
          emailController: _emailController,
          documentController: _documentController,
          nitController: _nitController,
          addressController: _addressController,
          phoneController: _phoneController,
          onSubmit: () {
            if (_formKey.currentState!.validate()) {
              // lógica para guardar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Datos guardados correctamente")),
              );
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}