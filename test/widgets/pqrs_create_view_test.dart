import 'package:ccp_mobile/features/pqrs/views/pqrs_create_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('PqrsCreateView muestra el AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: PqrsCreateView(orderId: 'ORD-123', customerId: 'CUS-456'),
      ),
    );

    expect(find.text('Registrar PQRS'), findsOneWidget);
  });
}