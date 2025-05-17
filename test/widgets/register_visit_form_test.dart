import 'package:ccp_mobile/features/clients/widgets/register_visit_form.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterVisitForm Widget Tests', () {
    testWidgets('debería renderizar campo de observaciones y botón',
        (WidgetTester tester) async {
      final customer = Customer(
        id: '1',
        name: 'Cliente Test',
        identificationNumber: '12345',
        assignedSeller: 'Vendedor Test',
        observations: 'Sin observaciones',
        userId: '42',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RegisterVisitForm(client: customer),
        ),
      );

      // Verifica que se renderizan los campos
      expect(find.byKey(const Key('observacionesField')), findsOneWidget);
      expect(find.byKey(const Key('registerVisitButton')), findsOneWidget);

      // Simula escritura de observación
      await tester.enterText(
          find.byKey(const Key('observacionesField')), 'Visita exitosa');
      expect(find.text('Visita exitosa'), findsOneWidget);

      // Tap en botón (sin mock de servicio no hará nada útil, pero lo detecta)
      await tester.tap(find.byKey(const Key('registerVisitButton')));
      await tester.pump(); // Para procesar el tap

      // Aquí puedes validar comportamiento posterior si mockeas el servicio
    });
  });
}