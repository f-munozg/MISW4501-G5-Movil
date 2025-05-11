import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PqrsForm extends StatelessWidget {
  final TextEditingController detailController;
  final VoidCallback onSubmit;

  const PqrsForm({
    super.key,
    required this.detailController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          key: const Key('detailField'),
          controller: detailController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.multiline, // Cambiado
          maxLines: null, // Importante para permitir múltiples líneas
          decoration: const InputDecoration(
            labelText: 'Detalle',
            labelStyle: TextStyle(color: Colors.white),
            hintText: 'Ingresa el detalle de la PQRS',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          key: const Key('createPqrsButton'),
          onPressed: onSubmit,
          child: const Text(
            'Crear PQRS',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
