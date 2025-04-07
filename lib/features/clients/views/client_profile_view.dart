import 'dart:convert';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../widgets/client_profile_form.dart';

class ClientProfileView extends StatefulWidget {
  const ClientProfileView({super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _documentController = TextEditingController();
  final _nitController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String? customerId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
  }

  /// Cargar datos del cliente en el formulario
  Future<void> _loadCustomerData() async {
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    customerId = userData['user_id'];
    if (customerId != null) {
      try {
        final customerWithStore =
            await CustomerService().getCustomerById(customerId!);
        setState(() {
          _nameController.text = customerWithStore.customer.name ?? '';
          _documentController.text =
              customerWithStore.customer.identificationNumber ?? '';
          _nitController.text =
              customerWithStore.store.identificationNumber ?? '';
          _addressController.text = customerWithStore.store.address ?? '';
          _phoneController.text = customerWithStore.store.phone ?? '';
        });
      } catch (e) {
        debugPrint('Error cargando cliente: $e');
      }
    }
  }

  /// Enviar datos del formulario
  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      final success = await CustomerService().updateCustomer(
        customerId!,
        _nameController.text,
        _emailController.text,
        _documentController.text,
        _nitController.text,
        _addressController.text,
        _phoneController.text,
      );

      setState(() => isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Datos guardados correctamente")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al guardar los datos")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onSubmit: _onSubmit,
        ),
      ),
    );
  }
}
