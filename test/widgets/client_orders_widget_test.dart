import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/features/clients/widgets/client_orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Clase simple de servicio simulado
class MockOrderService implements OrderService {
  final List<Order>? ordersToReturn;
  final Object? errorToThrow;

  MockOrderService({this.ordersToReturn, this.errorToThrow});

  @override
  Future<List<Order>?> getOrdersByCustomerId(String customerId) async {
    if (errorToThrow != null) {
      throw errorToThrow!;
    }
    // Simular un pequeño retraso para probar el indicador de carga
    await Future.delayed(const Duration(milliseconds: 100));
    return ordersToReturn;
  }

  // Implementa otros métodos de OrderService según sea necesario
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('Muestra mensaje de error cuando falla la carga',
      (WidgetTester tester) async {
    // Crear una implementación del servicio que lance un error
    final mockService = MockOrderService(errorToThrow: 'Error de conexión');

    // Crear widget con el servicio mock
    await tester.pumpWidget(
      MaterialApp(
        home: ClientOrdersWidget(
          clientId: '123',
          orderService: mockService,
        ),
      ),
    );

    // Esperar a que se complete el future con error
    await tester.pumpAndSettle();

    // Verificar que se muestra el mensaje de error
    expect(find.textContaining('Error:'), findsOneWidget);
  });

  testWidgets('Muestra mensaje cuando no hay órdenes disponibles',
      (WidgetTester tester) async {
    // Crear una implementación del servicio que devuelva una lista vacía
    final mockService = MockOrderService(ordersToReturn: []);

    // Crear widget con el servicio mock
    await tester.pumpWidget(
      MaterialApp(
        home: ClientOrdersWidget(
          clientId: '123',
          orderService: mockService,
        ),
      ),
    );

    // Esperar a que se complete el future
    await tester.pumpAndSettle();

    // Verificar que se muestra el mensaje correcto
    expect(find.text('No hay órdenes disponibles.'), findsOneWidget);
  });

  testWidgets('Muestra correctamente la lista de órdenes',
      (WidgetTester tester) async {
    // Crear órdenes de prueba
    final testOrders = [
      Order(
        id: '1',
        customerId: '123',
        dateDelivery: DateTime(2023, 5, 15),
        status: 'reserved',
        dateOrder: DateTime.now(),
      ),
      Order(
        id: '2',
        customerId: '123',
        dateDelivery: DateTime(2023, 5, 15),
        status: 'reserved',
        dateOrder: DateTime.now(),
      ),
    ];

    // Crear una implementación del servicio que devuelva las órdenes de prueba
    final mockService = MockOrderService(ordersToReturn: testOrders);

    // Crear widget con el servicio mock
    await tester.pumpWidget(
      MaterialApp(
        home: ClientOrdersWidget(
          clientId: '123',
          orderService: mockService,
        ),
      ),
    );

    // Esperar a que se complete el future
    await tester.pumpAndSettle();

    // Verificar que se muestran las dos órdenes (2 Cards)
    expect(find.byType(Card), findsNWidgets(2));

    // Verificar que se muestran los iconos de entrega
    expect(find.byIcon(Icons.delivery_dining), findsNWidgets(2));
  });
}
