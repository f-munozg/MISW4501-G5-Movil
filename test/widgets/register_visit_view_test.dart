import 'package:ccp_mobile/features/clients/views/register_visit_view.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RegisterVisitView muestra AppBar con título correcto', (WidgetTester tester) async {
    final customer = Customer(
      id: '123',
      name: 'Cliente Test',
      identificationNumber: 'ID123',
      userId: 'user_1',
      assignedSeller: 'seller_1',
      observations: 'Sin observaciones',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RegisterVisitView(client: customer),
      ),
    );
    
    expect(find.text('Registrar visita'), findsOneWidget);
  });
}