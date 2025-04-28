import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/order.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('Order constructor works correctly', () {
    final order = Order(
      id: '1',
      customerId: '123',
      sellerId: '456',
      dateOrder: DateTime(2025, 4, 27, 10, 30),
      dateDelivery: DateTime(2025, 4, 28, 10, 30),
      status: 'reserved',
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(order.id, '1');
    expect(order.customerId, '123');
    expect(order.sellerId, '456');
    expect(order.dateOrder, DateTime(2025, 4, 27, 10, 30));
    expect(order.dateDelivery, DateTime(2025, 4, 28, 10, 30));
    expect(order.status, 'reserved');
  });

  // Test 2: Verificar que fromJson convierte correctamente el mapa en un objeto Order
  test('Order.fromJson converts map to Order object', () {
    final json = {
      'id': '1',
      'customer_id': '123',
      'seller_id': '456',
      'date_order': '2025-04-27T10:30:00.000',
      'date_delivery': '2025-04-28T10:30:00.000',
      'status': 'reserved',
    };

    final order = Order.fromJson(json);

    // Verificamos que los campos del objeto Order coincidan con el JSON
    expect(order.id, '1');
    expect(order.customerId, '123');
    expect(order.sellerId, '456');
    expect(order.dateOrder, DateTime(2025, 4, 27, 10, 30));
    expect(order.dateDelivery, DateTime(2025, 4, 28, 10, 30));
    expect(order.status, 'reserved');
  });

  // Test 3: Verificar que toJson convierte correctamente el objeto Order en un mapa
  test('Order.toJson converts Order object to map', () {
    final order = Order(
      id: '1',
      customerId: '123',
      sellerId: '456',
      dateOrder: DateTime(2025, 4, 27, 10, 30),
      dateDelivery: DateTime(2025, 4, 28, 10, 30),
      status: 'reserved',
    );

    final json = order.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['id'], '1');
    expect(json['customer_id'], '123');
    expect(json['seller_id'], '456');
    expect(json['date_order'], '2025-04-27T10:30:00.000');
    expect(json['date_delivery'], '2025-04-28T10:30:00.000');
    expect(json['status'], 'reserved');
  });
}