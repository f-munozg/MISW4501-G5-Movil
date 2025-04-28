import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:ccp_mobile/core/models/product.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('CartItem constructor works correctly', () {
        final product = Product(
        id: '1',
        unitValue: 10.0,
        product: '',
        sku: '',
        photo: '',
        category: '',
        quantity: 0,
        estimatedDeliveryTime: DateTime.now(),
        dateUpdate: DateTime.now());

    // Crear CartItem con cantidad predeterminada
    final cartItem = CartItem(product: product);

    // Verificamos que el CartItem se creó correctamente
    expect(
        cartItem.product, product); // Verificamos que el producto es correcto
    expect(
        cartItem.quantity, 1); // Verificamos que la cantidad es 1 por defecto
  });

  // Test 2: Verificar que se puede asignar una cantidad específica
  test('CartItem constructor works with specified quantity', () {
        final product = Product(
        id: '1',
        unitValue: 10.0,
        product: '',
        sku: '',
        photo: '',
        category: '',
        quantity: 0,
        estimatedDeliveryTime: DateTime.now(),
        dateUpdate: DateTime.now());

    // Crear CartItem con cantidad especificada
    final cartItem = CartItem(product: product, quantity: 5);

    // Verificamos que la cantidad es la correcta
    expect(cartItem.product, product);
    expect(cartItem.quantity, 5);
  });

  // Test 3: Verificar que la cantidad puede ser modificada
  test('CartItem quantity can be modified', () {
    final product = Product(
        id: '1',
        unitValue: 10.0,
        product: '',
        sku: '',
        photo: '',
        category: '',
        quantity: 0,
        estimatedDeliveryTime: DateTime.now(),
        dateUpdate: DateTime.now());

    final cartItem = CartItem(product: product, quantity: 5);

    // Modificamos la cantidad
    cartItem.quantity = 10;

    // Verificamos que la cantidad ha sido actualizada
    expect(cartItem.quantity, 10);
  });
}
