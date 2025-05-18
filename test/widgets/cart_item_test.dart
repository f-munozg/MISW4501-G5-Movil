import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:ccp_mobile/core/models/product.dart';

void main() {
  final product = Product(
    id: '1',
    product: 'Laptop',
    sku: 'LPT123',
    unitValue: 1200.50,
    photo: 'https://example.com/laptop.jpg',
    category: 'Electronics',
    quantity: 15,
    estimatedDeliveryTime: DateTime.parse('2025-05-20T10:00:00.000Z'),
    dateUpdate: DateTime.parse('2025-05-15T12:00:00.000Z'),
  );

  group('CartItem', () {
    test('Constructor works with default quantity', () {
      final cartItem = CartItem(product: product);

      expect(cartItem.product, product);
      expect(cartItem.quantity, 1);
    });

    test('Constructor works with specified quantity', () {
      final cartItem = CartItem(product: product, quantity: 3);

      expect(cartItem.product, product);
      expect(cartItem.quantity, 3);
    });

    test('Quantity can be updated', () {
      final cartItem = CartItem(product: product, quantity: 5);

      cartItem.quantity = 10;

      expect(cartItem.quantity, 10);
    });

    test('toJson returns correct map', () {
      final cartItem = CartItem(product: product, quantity: 2);
      final json = cartItem.toJson();

      expect(json['quantity'], 2);
      expect(json['product'], product.toJson());
    });

    test('fromJson creates correct instance', () {
      final json = {
        'product': product.toJson(),
        'quantity': 4,
      };

      final cartItem = CartItem.fromJson(json);

      expect(cartItem.quantity, 4);
      expect(cartItem.product.id, '1');
      expect(cartItem.product.product, 'Laptop');
    });
  });
}