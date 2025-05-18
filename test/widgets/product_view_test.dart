import 'package:ccp_mobile/features/products/views/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';

void main() {
  group('ProductView UI Tests', () {
    testWidgets(
        'Muestra el CircularProgressIndicator mientras se cargan los productos',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(
            home: ProductView(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Contiene un AppBar con título "Productos" y botón del carrito',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
          child: const MaterialApp(
            home: ProductView(),
          ),
        ),
      );

      // Espera a que se renderice
      await tester.pump();

      expect(find.text('Productos'), findsOneWidget);
      expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
    });
  });
}
