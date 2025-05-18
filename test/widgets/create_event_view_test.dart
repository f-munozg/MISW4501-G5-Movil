import 'package:ccp_mobile/features/products/views/create_event_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Validar formulario vacío muestra errores', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RegisterEventForm()),
    );

    await tester.tap(find.text('Registrar'));
    await tester.pump();

    expect(find.text('Campo requerido'), findsNWidgets(4));
  });

  testWidgets('Al presionar icono calendario muestra DatePicker',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: RegisterEventForm()),
    );
    final calendarIcon = find.byIcon(Icons.calendar_today).first;
    await tester.tap(calendarIcon);
    await tester.pumpAndSettle();

    expect(find.text('SELECT DATE'), findsNothing);

    expect(find.text('OK'), findsOneWidget);
  });
}
