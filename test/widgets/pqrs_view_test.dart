import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PqrsView UI Tests', () {
    testWidgets(
        'Muestra el CircularProgressIndicator mientras se cargan las PQRS',
        (WidgetTester tester) async {
      final fakeClient = Customer(
        id: "1",
        name: 'Cliente Prueba',
        assignedSeller: 'Vendedor Prueba',
        observations: 'Sin observaciones',
        userId:"123",
        identificationNumber: 'ABC123456'
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PqrsView(client: fakeClient, isClient: true),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'Contiene un AppBar con título "PQRS" y botón de regreso visible',
        (WidgetTester tester) async {
      final fakeClient = Customer(
        id: "1",
        name: 'Cliente Prueba',
        assignedSeller: 'Vendedor Prueba',
        observations: 'Sin observaciones',
        userId: "123",
        identificationNumber: 'ABC123456'
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PqrsView(client: fakeClient, isClient: true),
        ),
      );

      await tester.pump();

      expect(find.text('PQRS'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}