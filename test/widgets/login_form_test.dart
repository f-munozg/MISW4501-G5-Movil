import 'package:ccp_mobile/features/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('LoginForm Widget Tests', () {
    testWidgets('debería renderizar los campos de texto y el botón',
        (WidgetTester tester) async {
      // Arrange
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      bool submitted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoginForm(
              emailController: emailController,
              passwordController: passwordController,
              onSubmit: () {
                submitted = true;
              },
            ),
          ),
        ),
      );

      // Assert - Verifica que los campos existan
      expect(find.byKey(const Key('loginEmailField')), findsOneWidget);
      expect(find.byKey(const Key('loginPasswordField')), findsOneWidget);
      expect(find.byKey(const Key('loginButton')), findsOneWidget);

      // Act - Escribir en los campos
      await tester.enterText(
          find.byKey(const Key('loginEmailField')), 'usuario@test.com');
      await tester.enterText(
          find.byKey(const Key('loginPasswordField')), '123456');

      // Verifica que el texto se haya escrito
      expect(emailController.text, 'usuario@test.com');
      expect(passwordController.text, '123456');

      // Presionar el botón
      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pump();

      // Verifica que se haya llamado el submit
      expect(submitted, isTrue);
    });
  });
}
