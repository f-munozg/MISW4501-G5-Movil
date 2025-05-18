import 'package:ccp_mobile/features/clients/views/client_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ClientProfileView muestra los campos del formulario y el botón', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: ClientProfileView()));

    expect(find.byType(TextFormField), findsNWidgets(6));

    await tester.enterText(find.byType(TextFormField).at(0), 'Juan Pérez');
    await tester.enterText(find.byType(TextFormField).at(1), 'juan@email.com');
    await tester.enterText(find.byType(TextFormField).at(2), '12345678');
    await tester.enterText(find.byType(TextFormField).at(3), 'NIT-987654');
    await tester.enterText(find.byType(TextFormField).at(4), 'Calle 123');
    await tester.enterText(find.byType(TextFormField).at(5), '3101234567');

    expect(find.text('Juan Pérez'), findsOneWidget);
    expect(find.text('juan@email.com'), findsOneWidget);

    expect(find.text('Guardar'), findsOneWidget);
  });
}