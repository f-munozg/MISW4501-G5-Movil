import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PqrsCreateForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController detailController;
  final VoidCallback onSubmit;

  const PqrsCreateForm({
    super.key,
    required this.titleController,
    required this.detailController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          TextField(
            key: const Key('titleField'),
            controller: titleController,
            style: const TextStyle(color: AppColors.primaryColor),
            decoration: const InputDecoration(
              labelText: 'Título',
              labelStyle: TextStyle(color: AppColors.primaryColor),
              hintText: 'Ingrese el título de la PQRS',
              hintStyle: TextStyle(color: AppColors.primaryColor),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('detailField'),
            controller: detailController,
            style: const TextStyle(color: AppColors.primaryColor),
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              labelText: 'Comentarios PQRS',
              labelStyle: TextStyle(color: AppColors.primaryColor),
              hintText: 'Ingrese el detalle de la PQRS',
              hintStyle: TextStyle(color: AppColors.primaryColor),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor),
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
    );
  }
}
