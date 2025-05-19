import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/features/clients/views/client_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ClientDetailView muestra datos del cliente y botones principales',
      (WidgetTester tester) async {
    
    final mockCustomer = Customer(
      id: "1",
      userId: "u1",
      name: "Juan Pérez",
      identificationNumber: "123456789",
      assignedSeller: "Vendedor Ejemplo",
      observations: "Sin observaciones",
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: ClientDetailView(client: mockCustomer),
      ),
    );
    
    expect(find.text("Juan Pérez"), findsOneWidget);
    
    expect(find.textContaining("CLIENTE #"), findsOneWidget);
    expect(find.text("CLIENTE # 123456789"), findsOneWidget);
    
    expect(find.text("Visitas"), findsOneWidget);
    expect(find.text("PQRS"), findsOneWidget);
    
    expect(find.text("Observaciones: "), findsOneWidget);
    expect(find.text("Sin observaciones"), findsOneWidget);
  });
}