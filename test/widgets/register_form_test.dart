import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/features/register/widgets/register_form.dart';

void main() {
  group('RegisterForm Widget Tests', () {
    testWidgets('debería renderizar los campos de texto y el botón',
        (WidgetTester tester) async {

      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      final confirmPasswordController = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RegisterForm(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              onSubmit: () {
              },
            ),
          ),
        ),
      );

      // Verificamos que los campos estén presentes
      expect(find.byKey(const Key('loginEmailField')), findsOneWidget);
      expect(find.byKey(const Key('loginPasswordField')), findsOneWidget);
      expect(find.byKey(const Key('loginButton')), findsOneWidget);

      // Escribimos en los campos
      await tester.enterText(
          find.byKey(const Key('loginEmailField')), 'usuario@test.com');
      await tester.enterText(
          find.byKey(const Key('loginPasswordField')), '123456');
      await tester.enterText(
          find.byKey(const Key('loginConfirmPasswordField')), '123456');
      await tester.pump();

      // Verificamos que el texto se haya ingresado correctamente
      expect(find.text('usuario@test.com'), findsOneWidget);
      expect(find.text('123456'), findsWidgets);
    });
  });
}