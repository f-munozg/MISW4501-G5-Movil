import 'package:ccp_mobile/core/services/pqrs_service.dart';
import 'package:ccp_mobile/features/pqrs/widgets/pqrs_create_form.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';

class PqrsCreateView extends StatefulWidget {
  final String orderId;
  final String customerId;

  const PqrsCreateView({
    super.key,
    required this.orderId,
    required this.customerId,
  });

  @override
  State<PqrsCreateView> createState() => _PqrsCreateViewState();
}

class _PqrsCreateViewState extends State<PqrsCreateView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  bool isLoading = false;

  void _handleSubmit() async {
    final title = titleController.text.trim();
    final detail = detailController.text.trim();

    if (title.isEmpty || detail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos los campos son obligatorios.')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final success = await PqrsService().createPqrs(
        title,
        detail,
        widget.orderId,
        widget.customerId,
      );

      if (success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PQRS creada exitosamente.')),
        );
        Navigator.pop(context); // O redirigir a otra pantalla si lo prefieres
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sesión expirada. Inicia sesión nuevamente.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear PQRS: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Registrar PQRS",
        showBackButton: true,
      ),
      body: Stack(
        children: [
          PqrsCreateForm(
            titleController: titleController,
            detailController: detailController,
            onSubmit: _handleSubmit,
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
