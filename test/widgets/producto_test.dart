import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/product.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('Product constructor works correctly', () {
    final product = Product(
      id: '1',
      product: 'Product A',
      sku: 'SKU123',
      unitValue: 10.0,
      photo: 'base64photo',
      category: 'Category A',
      quantity: 5,
      estimatedDeliveryTime: DateTime(2025, 5, 10),
      dateUpdate: DateTime(2025, 4, 27),
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(product.id, '1');
    expect(product.product, 'Product A');
    expect(product.sku, 'SKU123');
    expect(product.unitValue, 10.0);
    expect(product.photo, 'base64photo');
    expect(product.category, 'Category A');
    expect(product.quantity, 5);
    expect(product.estimatedDeliveryTime, DateTime(2025, 5, 10));
    expect(product.dateUpdate, DateTime(2025, 4, 27));
  });

  // Test 2: Verificar que fromJson convierte correctamente el mapa en un objeto Product
  test('Product.fromJson converts map to Product object', () {
    final json = {
      'id': '1',
      'product': 'Product A',
      'sku': 'SKU123',
      'unit_value': 10.0,
      'photo': 'base64photo',
      'category': 'Category A',
      'quantity': 5,
      'estimated_delivery_time': '2025-05-10T00:00:00.000',
      'date_update': '2025-04-27T00:00:00.000',
    };

    final product = Product.fromJson(json);

    // Verificamos que los campos del objeto Product coincidan con el JSON
    expect(product.id, '1');
    expect(product.product, 'Product A');
    expect(product.sku, 'SKU123');
    expect(product.unitValue, 10.0);
    expect(product.photo, 'base64photo');
    expect(product.category, 'Category A');
    expect(product.quantity, 5);
    expect(product.estimatedDeliveryTime, DateTime(2025, 5, 10));
    expect(product.dateUpdate, DateTime(2025, 4, 27));
  });

  // Test 3: Verificar que toJson convierte correctamente el objeto Product en un mapa
  test('Product.toJson converts Product object to map', () {
    final product = Product(
      id: '1',
      product: 'Product A',
      sku: 'SKU123',
      unitValue: 10.0,
      photo: 'base64photo',
      category: 'Category A',
      quantity: 5,
      estimatedDeliveryTime: DateTime(2025, 5, 10),
      dateUpdate: DateTime(2025, 4, 27),
    );

    final json = product.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['id'], '1');
    expect(json['product'], 'Product A');
    expect(json['sku'], 'SKU123');
    expect(json['unit_value'], 10.0);
    expect(json['photo'], 'base64photo');
    expect(json['category'], 'Category A');
    expect(json['quantity'], 5);
    expect(json['estimated_delivery_time'], '2025-05-10T00:00:00.000');
    expect(json['date_update'], '2025-04-27T00:00:00.000');
  });
}