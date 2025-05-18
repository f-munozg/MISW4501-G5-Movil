import 'dart:convert';
import 'dart:typed_data';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/product.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientRecomendationsView extends StatefulWidget {
  final Customer client;

  const ClientRecomendationsView({super.key, required this.client});

  @override
  State<ClientRecomendationsView> createState() =>
      _ClientRecomendationsViewState();
}

class _ClientRecomendationsViewState extends State<ClientRecomendationsView> {
  String purchaseSuggestion = '';
  List<Product> products = [];
  String? placementImageBase64;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    try {
      final response =
          await CustomerService().getCustomerSuggestions(widget.client.id);

      final rawProducts = response['products'] ?? [];

      final uniqueProducts = {
        for (var product in rawProducts) product['id']: product
      }.values.toList();

      setState(() {
        purchaseSuggestion = response['purchase'] ?? '';
        products = uniqueProducts
            .map<Product>((item) => Product.fromJson(item))
            .take(4)
            .toList();
        placementImageBase64 = response['placement'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Recomendaciones",
        showBackButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  const Text(
                    'Sugerencias de Compra:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(purchaseSuggestion,
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 16),
                  ...products.map((p) => _productoItem(p)).toList(),
                  const SizedBox(height: 24),
                  const Text(
                    'Sugerencias de Ubicación:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  if (placementImageBase64 != null)
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.memory(
                          base64Decode(placementImageBase64!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Icon(Icons.image_not_supported, size: 50)),
                    ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
    );
  }

  Widget _productoItem(Product product) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final sku = product.sku;
        final countInCart = cartProvider.items
            .where((item) => item.product.sku == sku)
            .fold(0, (sum, item) => sum + item.quantity);

        final decodedImage = _decodeBase64Image(product.photo);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: decodedImage != null
                          ? Image.memory(
                              decodedImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported,
                                  size: 40),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.product,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text("Categoría: ${product.category}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12)),
                          Text("Disponible: ${product.quantity}",
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12)),
                          Text("Precio: ${product.unitValue}",
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 13)),
                          if (countInCart > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("En carrito: x$countInCart",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${product.product} añadido al carrito')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Uint8List? _decodeBase64Image(String? base64String) {
    try {
      if (base64String == null || base64String.isEmpty) return null;
      return base64Decode(base64String.split(',').last);
    } catch (_) {
      return null;
    }
  }
}
