import 'package:ccp_mobile/features/clients/views/client_route_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ClientRouteDetailView muestra el AppBar con el título Ruta',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ClientRouteDetailView(
          eta: '15',
          routeMap: '', 
        ),
      ),
    );

    expect(find.text('Ruta'), findsOneWidget); 
  });

    testWidgets('ClientRouteDetailView muestra AppBar, ETA y ícono de imagen no disponible',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ClientRouteDetailView(
          eta: '15',
          routeMap: '',
        ),
      ),
    );
    
    expect(find.text('Ruta'), findsOneWidget);
  
    expect(find.text('15'), findsOneWidget);

    expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
  });
}