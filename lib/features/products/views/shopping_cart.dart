import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/products/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cart_provider.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Carrito",
        showBackButton: true,
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Tu carrito está vacío"))
          : ListView.builder(
              itemCount: cart.items.length,
              padding: const EdgeInsets.only(bottom: 100), // deja espacio abajo
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.asset(item.product.photo, width: 50),
                  title: Text(item.product.name),
                  subtitle: Text("Cantidad: ${item.quantity}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "\$${(item.product.unitValue * item.quantity).toStringAsFixed(2)}"),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => cart.removeProduct(item.product),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.items.isEmpty
          ? null
          : SafeArea(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, -2)),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton<String>(
                      hint: const Text("Selecciona un cliente"),
                      isExpanded: true,
                      value: cart.selectedClient,
                      items: const [
                        DropdownMenuItem(
                            value: "Cliente 1", child: Text("Cliente 1")),
                        DropdownMenuItem(
                            value: "Cliente 2", child: Text("Cliente 2")),
                      ],
                      onChanged: (value) {
                        if (value != null) cart.setClient(value);
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CheckoutView()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: AppColors.primaryColor, width: 2),
                          foregroundColor:
                              AppColors.primaryColor, // texto/icono
                          backgroundColor: Colors.white, // fondo del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // opcional
                          ),
                        ),
                        child: const Text("Reservar"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
