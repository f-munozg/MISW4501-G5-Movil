import 'dart:convert';
import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ClientRouteDetailView extends StatelessWidget {
  final String? eta;
  final String? routeMap;

  const ClientRouteDetailView({
    super.key,
    this.eta,
    this.routeMap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    ImageProvider? imageProvider;

    if (routeMap != null && routeMap!.isNotEmpty) {
      try {
        imageProvider =
            MemoryImage(base64Decode(routeMap!.replaceAll('\n', '').trim()));
      } catch (_) {
        imageProvider = null;
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ruta',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ruta más rápida:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    eta ?? "Visita no programada ",
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (eta != null) const Text(" min "),
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Container(
              height: screenHeight * 0.38, // 60% de la altura de la pantalla
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade100,
              ),
              child: imageProvider != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
