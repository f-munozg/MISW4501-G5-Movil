import 'package:ccp_mobile/features/clients/views/client_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClientView UI Tests', () {
    testWidgets('Contiene un AppBar con título "Clientes" y botón de agregar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ClientView(),
        ),
      );

      // Espera suficiente tiempo para evitar problemas de Timer
      await tester.pump(const Duration(milliseconds: 1000));

      expect(find.text('Clientes'), findsOneWidget);
      expect(find.byIcon(Icons.add_circle), findsOneWidget);
    });
  });
}