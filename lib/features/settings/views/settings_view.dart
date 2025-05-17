import 'dart:convert';

import 'package:ccp_mobile/core/constants/app_roles.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:ccp_mobile/features/clients/views/client_profile_view.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  final String userRole;

  Future<Customer?> loadCustomerData() async {
    final box = GetStorage();
    final userData = jsonDecode(box.read('user_data') ?? '{}');
    final customerId = userData['user_id'];
    if (customerId != null) {
      try {
        final customerWithStore =
            await CustomerService().getCustomerById(customerId!);
        return customerWithStore.customer;
      } catch (e) {
        debugPrint('Error cargando cliente: $e');
        return null;
      }
    }
    return null;
  }

  const SettingsView({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final isClient = userRole == AppRoles.client;
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Settings",
        showBackButton: false,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  if (isClient)
                    ListTile(
                      leading: const Icon(Icons.person,
                          color: AppColors.primaryColor),
                      title: const Text("Mis datos"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ClientProfileView()),
                        );
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.language,
                        color: AppColors.primaryColor),
                    title: const Text("Idioma"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_increase,
                        color: AppColors.primaryColor),
                    title: const Text("Tamaño de texto"),
                  ),
                  if (isClient)
                    ListTile(
                      leading: const Icon(Icons.question_answer,
                          color: AppColors.primaryColor),
                      title: const Text("Mis PQRS"),
                      onTap: () async {
                        final customer = await loadCustomerData();
                        if (customer == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error al cargar los datos del cliente"),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PqrsView(client: customer, isClient: true,)),
                        );
                      },
                    ),
                  ListTile(
                    leading:
                        const Icon(Icons.logout, color: AppColors.primaryColor),
                    title: const Text("Cerrar sesión"),
                    onTap: () async {
                      final box = GetStorage();
                      cart.clearCart();
                      await box.remove('user_data');

                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                  ),
                  const Divider(),
                  const ListTile(
                    leading:
                        Icon(Icons.info_outline, color: AppColors.primaryColor),
                    title: Text("CCP Mobile v1.0.0"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
