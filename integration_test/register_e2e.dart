import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login correcto redirige al HomeScreen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.text('¿Eres tendero? Regístrate aquí'));

    await tester.pumpAndSettle();

    final emailField = find.byKey(const Key('loginEmailField'));
    final passwordField = find.byKey(const Key('loginPasswordField'));
    final confirmPasswordField = find.byKey(const Key('loginConfirmPasswordField'));
    final registerButton = find.byKey(const Key('loginButton'));

    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(confirmPasswordField, findsOneWidget);
    expect(registerButton, findsOneWidget);
    
    await tester.enterText(emailField, 'usuario@test.com');
    await tester.enterText(passwordField, 'password123');
    await tester.enterText(confirmPasswordField, 'password123');

    await tester.pumpAndSettle();

    
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    
    expect(find.text('Registro exitoso'), findsOneWidget);
  });
}