import 'package:ccp_mobile/features/orders/widgets/order_detail_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ccp_mobile/core/models/product.dart';
import 'package:ccp_mobile/core/models/cart_item.dart';


void main() {
  testWidgets('Muestra producto y cantidad, y responde al botón "+"',
      (WidgetTester tester) async {
    final product = Product(
      id: 'p1',
      sku: '001',
      product: 'Producto de prueba',
      unitValue: 15000,
      photo: 'https://example.com/photo.jpg',
      category: 'Test Category',
      quantity: 10,
      estimatedDeliveryTime: DateTime.now(),
      dateUpdate: DateTime.now(),
    );
    final cartItem = CartItem(product: product, quantity: 3);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderDetailListWidget(
            items: [cartItem],
            showAddButton: true,
          ),
        ),
      ),
    );

    // Verifica que se muestre el nombre y la cantidad y el boton "+"
    expect(find.text('Producto: Producto de prueba'), findsOneWidget);
    expect(find.text('Cantidad: 3'), findsOneWidget);
    expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
  });

  testWidgets('No muestra botón "+" cuando showAddButton es false',
      (WidgetTester tester) async {
    final product = Product(
      id: 'p1',
      sku: '001',
      product: 'Producto de prueba',
      unitValue: 15000,
      photo: 'https://example.com/photo.jpg',
      category: 'Test Category',
      quantity: 10,
      estimatedDeliveryTime: DateTime.now(),
      dateUpdate: DateTime.now(),
    );
    final cartItem = CartItem(product: product, quantity: 1);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OrderDetailListWidget(
            items: [cartItem],
            showAddButton: false,
          ),
        ),
      ),
    );

    // Verifica que el botón "+" NO está presente
    expect(find.byIcon(Icons.add_circle_outline), findsNothing);
  });
}