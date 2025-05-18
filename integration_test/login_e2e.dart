import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login correcto redirige al HomeScreen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();


    final emailField = find.byKey(const Key('loginEmailField'));
    final passwordField = find.byKey(const Key('loginPasswordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(emailField, 'felipegonzalez');
    await tester.enterText(passwordField, '123456789');
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
  });
}