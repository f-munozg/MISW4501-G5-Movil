import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/pqrs.dart';

void main() {
  final createdAt = DateTime.parse('2025-05-01T10:00:00.000Z');
  final updatedAt = DateTime.parse('2025-05-15T12:30:00.000Z');

  group('Pqrs', () {
    test('Constructor works correctly with all fields', () {
      final pqrs = Pqrs(
        orderId: 'ORD123',
        sellerId: 'SELLER1',
        id: 'PQRS1',
        title: 'Reclamo por producto',
        status: 'abierto',
        customerId: 'CUST1',
        createdAt: createdAt,
        type: 'reclamo',
        description: 'Producto en mal estado',
        updatedAt: updatedAt,
        amount: 120.50,
      );

      expect(pqrs.orderId, 'ORD123');
      expect(pqrs.sellerId, 'SELLER1');
      expect(pqrs.id, 'PQRS1');
      expect(pqrs.title, 'Reclamo por producto');
      expect(pqrs.status, 'abierto');
      expect(pqrs.customerId, 'CUST1');
      expect(pqrs.createdAt, createdAt);
      expect(pqrs.type, 'reclamo');
      expect(pqrs.description, 'Producto en mal estado');
      expect(pqrs.updatedAt, updatedAt);
      expect(pqrs.amount, 120.50);
    });

    test('toJson returns correct map', () {
      final pqrs = Pqrs(
        orderId: 'ORD123',
        sellerId: 'SELLER1',
        id: 'PQRS1',
        title: 'Reclamo por producto',
        status: 'abierto',
        customerId: 'CUST1',
        createdAt: createdAt,
        type: 'reclamo',
        description: 'Producto en mal estado',
        updatedAt: updatedAt,
        amount: 120.50,
      );

      final json = pqrs.toJson();

      expect(json['order_id'], 'ORD123');
      expect(json['seller_id'], 'SELLER1');
      expect(json['id'], 'PQRS1');
      expect(json['title'], 'Reclamo por producto');
      expect(json['status'], 'abierto');
      expect(json['customer_id'], 'CUST1');
      expect(json['created_at'], createdAt.toIso8601String());
      expect(json['type'], 'reclamo');
      expect(json['description'], 'Producto en mal estado');
      expect(json['updated_at'], updatedAt.toIso8601String());
      expect(json['amount'], 120.50);
    });

    test('fromJson creates correct instance', () {
      final json = {
        'order_id': 'ORD123',
        'seller_id': 'SELLER1',
        'id': 'PQRS1',
        'title': 'Reclamo por producto',
        'status': 'abierto',
        'customer_id': 'CUST1',
        'created_at': '2025-05-01T10:00:00.000Z',
        'type': 'reclamo',
        'description': 'Producto en mal estado',
        'updated_at': '2025-05-15T12:30:00.000Z',
        'amount': 120.50,
      };

      final pqrs = Pqrs.fromJson(json);

      expect(pqrs.orderId, 'ORD123');
      expect(pqrs.sellerId, 'SELLER1');
      expect(pqrs.id, 'PQRS1');
      expect(pqrs.title, 'Reclamo por producto');
      expect(pqrs.status, 'abierto');
      expect(pqrs.customerId, 'CUST1');
      expect(pqrs.createdAt.toIso8601String(), '2025-05-01T10:00:00.000Z');
      expect(pqrs.type, 'reclamo');
      expect(pqrs.description, 'Producto en mal estado');
      expect(pqrs.updatedAt.toIso8601String(), '2025-05-15T12:30:00.000Z');
      expect(pqrs.amount, 120.50);
    });

    test('fromJson handles null optional fields', () {
      final json = {
        'seller_id': null,
        'order_id': null,
        'id': 'PQRS2',
        'title': 'Consulta de envío',
        'status': 'cerrado',
        'customer_id': 'CUST2',
        'created_at': '2025-04-01T08:00:00.000Z',
        'type': 'consulta',
        'description': '¿Cuándo llega mi pedido?',
        'updated_at': '2025-04-02T08:00:00.000Z',
        'amount': null,
      };

      final pqrs = Pqrs.fromJson(json);

      expect(pqrs.orderId, isNull);
      expect(pqrs.sellerId, isNull);
      expect(pqrs.amount, isNull);
      expect(pqrs.title, 'Consulta de envío');
    });
  });
}