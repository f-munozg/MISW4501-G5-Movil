import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/widgets/register_visit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Formulario de Registrar Visita funciona correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RegisterVisitForm(client: Customer(
            id: '1',
            name: 'Cliente de Prueba',
            identificationNumber: '123456789',
            assignedSeller: 'Vendedor Asignado',
            observations: 'Sin observaciones',
            userId: 'user123',
          )),
        ),
      ),
    );

    // Verifica que todos los campos estén presentes
    expect(find.byKey(const Key('nameField')), findsOneWidget);
    expect(find.byKey(const Key('startDateField')), findsOneWidget);
    expect(find.byKey(const Key('endDateField')), findsOneWidget);
    expect(find.byKey(const Key('locationBox')), findsOneWidget);
    expect(find.byKey(const Key('submitButton')), findsOneWidget);

    // Ingresa un nombre
    await tester.enterText(find.byKey(const Key('nameField')), 'Visita Técnica');

    // Simula tap en botón de registrar
    await tester.tap(find.byKey(const Key('submitButton')));
    await tester.pump();
  });
}