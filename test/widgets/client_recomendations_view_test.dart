import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/views/client_recomendations_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ccp_mobile/core/providers/cart_provider.dart';

void main() {
  group('ClientRecomendationsView UI Tests', () {
    testWidgets('Contiene título y se muestra CircularProgressIndicator mientras carga',
        (WidgetTester tester) async {
      
      final customer = Customer(
        id: "1",
        name: 'Cliente Prueba',
        assignedSeller: 'Vendedor Prueba',
        observations: 'Sin observaciones',
        userId: "123",
        identificationNumber: '1234567890',
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: MaterialApp(
            home: ClientRecomendationsView(client: customer),
          ),
        ),
      );
      // Assert: muestra el título del AppBar y el indicador de carga
      expect(find.text('Recomendaciones'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Contiene secciones de sugerencias de compra y ubicación',
        (WidgetTester tester) async {
      final customer = Customer(
        id: "1",
        name: 'Cliente Prueba',
        assignedSeller: 'Vendedor Prueba',
        observations: 'Sin observaciones',
        userId: "123",
        identificationNumber: '1234567890',
      );

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
          child: MaterialApp(
            home: ClientRecomendationsView(client: customer),
          ),
        ),
      );

    
      await tester.pump(const Duration(seconds: 2));

      
      expect(find.text('Sugerencias de Compra:'), findsOneWidget);
      expect(find.text('Sugerencias de Ubicación:'), findsOneWidget);
    });
  });
}