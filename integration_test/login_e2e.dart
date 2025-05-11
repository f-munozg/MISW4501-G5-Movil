import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login correcto redirige al HomeScreen', (WidgetTester tester) async {
    // Inicia la app completa
    app.main();
    await tester.pumpAndSettle();

    // Ingresa texto en los campos
    final emailField = find.byKey(const Key('loginEmailField'));
    final passwordField = find.byKey(const Key('loginPasswordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(emailField, 'felipegonzalez');
    await tester.enterText(passwordField, '123456789');
    await tester.tap(loginButton);

    // Espera a que termine la animación y las peticiones
    await tester.pumpAndSettle();

    // Verifica si estamos en la pantalla de Home (puedes usar un texto, un key o cualquier widget único)
    expect(find.text('Pedidos'), findsOneWidget);
  });
}