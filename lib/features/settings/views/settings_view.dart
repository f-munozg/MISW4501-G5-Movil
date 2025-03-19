import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../routes/app_routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
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
            // Menú de opciones
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.language, color: AppColors.primaryColor),
                    title: const Text("Idioma"),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.text_increase, color: AppColors.primaryColor),
                    title: const Text("Tamaño de texto"),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.logout, color: AppColors.primaryColor),
                    title: const Text("Cerrar sesión"),
                    onTap: () {
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
