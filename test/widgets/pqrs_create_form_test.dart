import 'package:ccp_mobile/features/pqrs/widgets/pqrs_create_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('PqrsCreateForm Widget Test', () {
    late TextEditingController titleController;
    late TextEditingController detailController;
    bool onSubmitCalled = false;

    setUp(() {
      titleController = TextEditingController();
      detailController = TextEditingController();
      onSubmitCalled = false;
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: Scaffold(
          body: PqrsCreateForm(
            titleController: titleController,
            detailController: detailController,
            onSubmit: () {
              onSubmitCalled = true;
            },
          ),
        ),
      );
    }

    testWidgets('renders title and detail fields', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byKey(const Key('titleField')), findsOneWidget);
      expect(find.byKey(const Key('detailField')), findsOneWidget);
      expect(find.byKey(const Key('createPqrsButton')), findsOneWidget);
    });

    testWidgets('allows text input in title and detail fields', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.enterText(find.byKey(const Key('titleField')), 'Prueba de Título');
      await tester.enterText(find.byKey(const Key('detailField')), 'Detalle de prueba');

      expect(titleController.text, 'Prueba de Título');
      expect(detailController.text, 'Detalle de prueba');
    });

    testWidgets('calls onSubmit when button is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      await tester.tap(find.byKey(const Key('createPqrsButton')));
      await tester.pump(); // Espera a que se complete la acción

      expect(onSubmitCalled, isTrue);
    });
  });
}