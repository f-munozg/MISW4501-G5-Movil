import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ClientProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController documentController;
  final TextEditingController nitController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  const ClientProfileForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.documentController,
    required this.nitController,
    required this.addressController,
    required this.phoneController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            key: const Key('nameField'),
            controller: nameController,
            decoration: const InputDecoration(labelText: "Nombre completo"),
            validator: (value) =>
                value!.isEmpty ? "Este campo es requerido" : null,
          ),
          TextFormField(
            key: const Key('emailField'),
            controller: emailController,
            decoration: const InputDecoration(labelText: "Correo electrónico"),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value!.isEmpty ? "Este campo es requerido" : null,
          ),
          TextFormField(
            key: const Key('documentField'),
            controller: documentController,
            decoration:
                const InputDecoration(labelText: "Documento de identidad"),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            key: const Key('nitField'),
            controller: nitController,
            decoration: const InputDecoration(labelText: "NIT"),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            key: const Key('addressField'),
            controller: addressController,
            decoration: const InputDecoration(labelText: "Dirección"),
          ),
          TextFormField(
            key: const Key('phoneField'),
            controller: phoneController,
            decoration: const InputDecoration(labelText: "Teléfono"),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            key: const Key('submitButton'),
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryColor, width: 2),
              foregroundColor: AppColors.primaryColor,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
