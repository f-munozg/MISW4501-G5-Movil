import 'package:ccp_mobile/core/constants/app_roles.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:ccp_mobile/features/clients/views/client_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  final String userRole;
  

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
                      leading: const Icon(Icons.person, color: AppColors.primaryColor),
                      title: const Text("Mis datos"),
                      onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ClientProfileView()),
                        );
                        
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.language, color: AppColors.primaryColor),
                    title: const Text("Idioma"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.text_increase, color: AppColors.primaryColor),
                    title: const Text("Tamaño de texto"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: AppColors.primaryColor),
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
                    leading: Icon(Icons.info_outline, color: AppColors.primaryColor),
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