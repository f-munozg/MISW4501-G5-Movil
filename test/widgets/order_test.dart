import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/models/cart_item.dart';
import 'package:ccp_mobile/core/models/product.dart';

void main() {
  final dateOrder = DateTime.parse('2025-05-10T09:00:00.000Z');
  final dateDelivery = DateTime.parse('2025-05-12T15:00:00.000Z');
  final dateUpdate = DateTime.parse('2025-05-09T12:00:00.000Z');
  final estimatedDelivery = DateTime.parse('2025-05-11T00:00:00.000Z');

  final product1 = Product(
    id: 'P1',
    product: 'Laptop',
    sku: 'LP123',
    unitValue: 1200.50,
    photo: 'photo_url',
    category: 'Electronics',
    quantity: 10,
    estimatedDeliveryTime: estimatedDelivery,
    dateUpdate: dateUpdate,
  );

  final product2 = Product(
    id: 'P2',
    product: 'Mouse',
    sku: 'MS456',
    unitValue: 25.75,
    photo: 'photo_url_2',
    category: 'Accessories',
    quantity: 30,
    estimatedDeliveryTime: estimatedDelivery,
    dateUpdate: dateUpdate,
  );

  final cartItems = [
    CartItem(product: product1, quantity: 1),
    CartItem(product: product2, quantity: 3),
  ];

  group('Order', () {
    test('Constructor funciona correctamente', () {
      final order = Order(
        id: 'O1',
        customerId: 'C1',
        sellerId: 'S1',
        dateOrder: dateOrder,
        dateDelivery: dateDelivery,
        status: 'pending',
        products: cartItems,
      );

      expect(order.id, 'O1');
      expect(order.customerId, 'C1');
      expect(order.sellerId, 'S1');
      expect(order.dateOrder, dateOrder);
      expect(order.dateDelivery, dateDelivery);
      expect(order.status, 'pending');
      expect(order.products.length, 2);
      expect(order.products.first.product.sku, 'LP123');
    });

    test('toJson retorna el mapa esperado', () {
      final order = Order(
        id: 'O1',
        customerId: 'C1',
        sellerId: 'S1',
        dateOrder: dateOrder,
        dateDelivery: dateDelivery,
        status: 'pending',
        products: cartItems,
      );

      final json = order.toJson();

      expect(json['id'], 'O1');
      expect(json['customer_id'], 'C1');
      expect(json['seller_id'], 'S1');
      expect(json['date_order'], dateOrder.toIso8601String());
      expect(json['date_delivery'], dateDelivery.toIso8601String());
      expect(json['status'], 'pending');
      expect(json['products'], isA<List>());
      expect(json['products'][0]['product']['sku'], 'LP123');
      expect(json['products'][1]['quantity'], 3);
    });

    test('fromJson crea una instancia válida', () {
      final json = {
        'id': 'O1',
        'customer_id': 'C1',
        'seller_id': 'S1',
        'date_order': '2025-05-10T09:00:00.000Z',
        'date_delivery': '2025-05-12T15:00:00.000Z',
        'status': 'pending',
        'products': [
          {
            'product': {
              'id': 'P1',
              'product': 'Laptop',
              'sku': 'LP123',
              'unit_value': 1200.50,
              'photo': 'photo_url',
              'category': 'Electronics',
              'quantity': 10,
              'estimated_delivery_time': '2025-05-11T00:00:00.000Z',
              'date_update': '2025-05-09T12:00:00.000Z',
            },
            'quantity': 1,
          },
          {
            'product': {
              'id': 'P2',
              'product': 'Mouse',
              'sku': 'MS456',
              'unit_value': 25.75,
              'photo': 'photo_url_2',
              'category': 'Accessories',
              'quantity': 30,
              'estimated_delivery_time': '2025-05-11T00:00:00.000Z',
              'date_update': '2025-05-09T12:00:00.000Z',
            },
            'quantity': 3,
          }
        ],
      };

      final order = Order.fromJson(json);

      expect(order.id, 'O1');
      expect(order.customerId, 'C1');
      expect(order.products.length, 2);
      expect(order.products[0].product.unitValue, 1200.50);
      expect(order.products[1].product.category, 'Accessories');
    });

    test('fromJson maneja campos opcionales y lista vacía', () {
      final json = {
        'id': 'O2',
        'customer_id': 'C2',
        'seller_id': null,
        'date_order': '2025-05-01T10:00:00.000Z',
        'date_delivery': '2025-05-05T10:00:00.000Z',
        'status': 'completed',
        'products': [],
      };

      final order = Order.fromJson(json);

      expect(order.sellerId, isNull);
      expect(order.products, isEmpty);
    });
  });
}