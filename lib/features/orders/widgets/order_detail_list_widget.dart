import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderDetailListWidget extends StatelessWidget {
  final List<CartItem> items;
  final bool showAddButton;

  const OrderDetailListWidget({
    super.key,
    required this.items,
    this.showAddButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(thickness: 1),
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Producto: ${item.product.product}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text('Cantidad: ${item.quantity}'),
              if (showAddButton)
                IconButton(
                  icon: const Icon(Icons.add_circle_outline, color: Color(0xFF154C45)),
                  onPressed: () {
                    // Agrega al carrito desde el Provider
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(item.product);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}