import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/features/stock/views/stock_view.dart';

void main() {
  testWidgets('StockView muestra el texto "Lista de stock"', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: StockView(),
      ),
    );
    expect(find.text('Lista de stock'), findsOneWidget);
  });
}