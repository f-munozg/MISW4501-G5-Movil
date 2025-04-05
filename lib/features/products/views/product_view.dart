import 'package:ccp_mobile/core/models/product.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:ccp_mobile/features/products/views/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ProductView extends StatelessWidget {
  
  ProductView({super.key});

  final List<Product> products = [
    Product(
      sku: "ABC123",
      name: "Producto 1",
      unitValue: 19.99,
      conditionsStorage: "Almacenar en un lugar seco",
      productFeatures: "Resistente al agua",
      providerId: "debedacc-3e31-4003-8986-871637d727af",
      timeDeliveryDear: DateTime(2025, 4, 1),
      photo: 'assets/images/LogoCCP.png', // Imagen de ejemplo
      description: "Este es un producto de prueba.",
    ),
    Product(
      sku: "XYZ789",
      name: "Producto 2",
      unitValue: 29.99,
      conditionsStorage: "Mantener refrigerado",
      productFeatures: "Ecológico",
      providerId: "b1234567-3e31-4003-8986-871637d727af",
      timeDeliveryDear: DateTime(2025, 5, 10),
      photo: 'assets/images/LogoCCP.png',
      description: "Otro producto de prueba.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Productos",
        showBackButton: false,
        actionButton: IconButton(
          icon: Badge(
            label: Consumer<CartProvider>(
              builder: (_, cart, __) => Text('${cart.itemCount}'),
            ),
            child: const Icon(Icons.shopping_cart, color: Colors.white,),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ShoppingCartView()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 elementos por fila
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8, // Ajusta el tamaño de las tarjetas
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(product.photo,
                              fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("\$${product.unitValue.toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${product.name} añadido al carrito')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
