import 'package:ccp_mobile/features/clients/widgets/client_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClientProfileForm Widget Tests', () {
    testWidgets('Renders all fields and submits', (WidgetTester tester) async {
      final nameController = TextEditingController();
      final emailController = TextEditingController();
      final documentController = TextEditingController();
      final nitController = TextEditingController();
      final addressController = TextEditingController();
      final phoneController = TextEditingController();
      final formKey = GlobalKey<FormState>();
      bool submitted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ClientProfileForm(
              formKey: formKey,
              nameController: nameController,
              emailController: emailController,
              documentController: documentController,
              nitController: nitController,
              addressController: addressController,
              phoneController: phoneController,
              onSubmit: () {
                submitted = true;
              },
            ),
          ),
        ),
      );

      // Verifica que todos los campos estén presentes
      expect(find.byKey(const Key('nameField')), findsOneWidget);
      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('documentField')), findsOneWidget);
      expect(find.byKey(const Key('nitField')), findsOneWidget);
      expect(find.byKey(const Key('addressField')), findsOneWidget);
      expect(find.byKey(const Key('phoneField')), findsOneWidget);
      expect(find.byKey(const Key('submitButton')), findsOneWidget);

      // Escribe datos en los campos
      await tester.enterText(find.byKey(const Key('nameField')), 'Juan Pérez');
      await tester.enterText(find.byKey(const Key('emailField')), 'juan@test.com');
      await tester.enterText(find.byKey(const Key('documentField')), '123456789');
      await tester.enterText(find.byKey(const Key('nitField')), '987654321');
      await tester.enterText(find.byKey(const Key('addressField')), 'Calle Falsa 123');
      await tester.enterText(find.byKey(const Key('phoneField')), '555123456');

      // Toca el botón para enviar
      await tester.tap(find.byKey(const Key('submitButton')));
      await tester.pump();

      // Verifica que se haya ejecutado la función
      expect(submitted, isTrue);
    });
  });
}