import 'package:ccp_mobile/features/pqrs/views/pqrs_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/pqrs.dart';

void main() {
  group('PqrsDetailView', () {
    late Pqrs pqrs;

    setUp(() {
      pqrs = Pqrs(
        id: 'PQR-001',
        title: 'Producto defectuoso',
        description: 'El producto llegó dañado.',
        amount: 15000,
        createdAt: DateTime(2025, 5, 16),
        updatedAt: DateTime(2025, 5, 17),
        status: 'abierto',
        orderId: 'ORD-123',
        sellerId: 'SELLER-001',
        customerId: 'CUSTOMER-001',
        type: 'reclamo',
      );
    });

    testWidgets('Muestra los datos básicos de la PQRS', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PqrsDetailView(pqrs: pqrs, isClient: false),
        ),
      );

      expect(find.text('PQR'), findsOneWidget);
      expect(find.text(pqrs.id), findsOneWidget);
      expect(find.textContaining('Fecha de creación'), findsOneWidget);
      expect(find.textContaining('Monto reembolso'), findsOneWidget);
      expect(find.text(pqrs.title), findsOneWidget);
      expect(find.text(pqrs.description), findsOneWidget);
    });

    testWidgets('Muestra el botón "Responder" si no es cliente y el estado no es cerrado',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PqrsDetailView(pqrs: pqrs, isClient: false),
        ),
      );

      expect(find.text('Responder'), findsOneWidget);
    });

    testWidgets('No muestra el botón "Responder" si es cliente',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PqrsDetailView(pqrs: pqrs, isClient: true),
        ),
      );

      expect(find.text('Responder'), findsNothing);
    });
  });
}