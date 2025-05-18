import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/views/client_visits_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClientVisitsView Widget Test', () {
    testWidgets('Muestra loader al iniciar y datos tras carga',
        (WidgetTester tester) async {
      // Datos simulados
      final customer = Customer(
        id: "2",
        name: 'Cliente de prueba',
        assignedSeller: 'Vendedor de prueba',
        observations: 'Observaciones de prueba',
        userId: '123',
        identificationNumber: '0000000000',
      );
      final widget = MaterialApp(home: ClientVisitsView(client: customer));

      await tester.pumpWidget(widget);

      // Verifica que se muestre el loader al inicio
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Avanza el tiempo para permitir carga (simula Future delay)
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verifica títulos
      expect(find.text("Visitas"), findsOneWidget);
      expect(find.text("RUTA SUGERIDA"), findsOneWidget);
    });

    testWidgets('No muestra botón de Crear visita si no hay sugeridas',
        (WidgetTester tester) async {
      final customer = Customer(
        id: "1",
        name: 'Sin visitas sugeridas',
        assignedSeller: 'Vendedor de prueba',
        observations: 'Sin observaciones',
        userId: "123",
        identificationNumber: '0000000000',
      );
      final widget = MaterialApp(home: ClientVisitsView(client: customer));

      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text("No tiene visitas pendientes."), findsOneWidget);
      expect(find.text("Crear visita"), findsNothing);
    });
  });
}