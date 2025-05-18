import 'package:ccp_mobile/features/login/views/login_view.dart';
import 'package:ccp_mobile/features/register/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Muestra elementos principales en LoginView', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));
    expect(find.text('¿Eres tendero? Regístrate aquí'), findsOneWidget);
  });

  testWidgets('Navega a RegisterView al tocar el link', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginView()));

    await tester.tap(find.text('¿Eres tendero? Regístrate aquí'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterView), findsOneWidget);
  });
}