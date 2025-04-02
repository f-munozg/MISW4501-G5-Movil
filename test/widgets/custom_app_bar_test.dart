import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CustomAppBar muestra el título correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(title: 'Mi AppBar'),
        ),
      ),
    );

    // Verifica que el título se muestra
    expect(find.text('Mi AppBar'), findsOneWidget);
  });

  testWidgets('CustomAppBar muestra el botón de retroceso si está habilitado', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(title: 'Con Back', showBackButton: true),
        ),
      ),
    );

    // Verifica que el icono de retroceso se muestra
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('CustomAppBar ejecuta onBackPressed al presionar el botón de retroceso', (WidgetTester tester) async {
    bool backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(
            title: 'Con Acción',
            showBackButton: true,
            onBackPressed: () {
              backPressed = true;
            },
          ),
        ),
      ),
    );

    // Simula la pulsación del botón de retroceso
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pump();

    // Verifica que la función onBackPressed fue ejecutada
    expect(backPressed, isTrue);
  });

  testWidgets('CustomAppBar muestra un botón de acción cuando se proporciona', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(
            title: 'Con Acción',
            actionButton: IconButton(
              key: Key('action_button'),
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // Verifica que el botón de acción está presente
    expect(find.byKey(Key('action_button')), findsOneWidget);
  });
}