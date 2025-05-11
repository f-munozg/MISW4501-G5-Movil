import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PqrsCreateForm extends StatelessWidget {
  final TextEditingController detailController;
  final VoidCallback onSubmit;

  const PqrsCreateForm({
    super.key,
    required this.detailController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              TextField(
                key: const Key('detailField'),
                controller: detailController,
                style: const TextStyle(color: Colors.green),
                keyboardType: TextInputType.multiline, // Cambiado
                maxLines: null, // Importante para permitir múltiples líneas
                decoration: const InputDecoration(
                  labelText: 'Comentarios PQRS',
                  labelStyle: TextStyle(color: Colors.green),
                  hintText: 'Ingresa el detalle de la PQRS',
                  hintStyle: TextStyle(color: Colors.green),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
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
          ),
        ),
      ],
    );
  }
}
