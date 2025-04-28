import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/stock.dart';
import 'package:ccp_mobile/core/models/product.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('Stock constructor works correctly', () {
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
    
    final stock = Stock(
      total: 100,
      limit: 10,
      offset: 0,
      results: [product],
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(stock.total, 100);
    expect(stock.limit, 10);
    expect(stock.offset, 0);
    expect(stock.results.length, 1); // Verificamos que la lista de productos tenga 1 elemento
    expect(stock.results[0], product); // Verificamos que el primer producto sea el correcto
  });

  // Test 2: Verificar que fromJson convierte correctamente el mapa en un objeto Stock
  test('Stock.fromJson converts map to Stock object', () {
    final json = {
      'total': 100,
      'limit': 10,
      'offset': 0,
      'results': [
        {
          'id': '1',
          'product': 'Product A',
          'sku': 'SKU123',
          'unit_value': 10.0,
          'photo': 'base64photo',
          'category': 'Category A',
          'quantity': 5,
          'estimated_delivery_time': '2025-05-10T00:00:00.000',
          'date_update': '2025-04-27T00:00:00.000',
        }
      ],
    };

    final stock = Stock.fromJson(json);

    // Verificamos que los campos del objeto Stock coincidan con el JSON
    expect(stock.total, 100);
    expect(stock.limit, 10);
    expect(stock.offset, 0);
    expect(stock.results.length, 1); // Verificamos que hay un solo producto
    expect(stock.results[0].id, '1'); // Verificamos que el ID del producto sea el correcto
    expect(stock.results[0].product, 'Product A'); // Verificamos que el nombre del producto sea correcto
    expect(stock.results[0].unitValue, 10.0); // Verificamos que el precio del producto sea correcto
  });

  // Test 3: Verificar que toJson convierte correctamente el objeto Stock en un mapa
  test('Stock.toJson converts Stock object to map', () {
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
    
    final stock = Stock(
      total: 100,
      limit: 10,
      offset: 0,
      results: [product],
    );

    final json = stock.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['total'], 100);
    expect(json['limit'], 10);
    expect(json['offset'], 0);
    expect(json['results'].length, 1); // Verificamos que la lista de productos tiene 1 producto
    expect(json['results'][0]['id'], '1'); // Verificamos que el ID del producto sea el correcto
    expect(json['results'][0]['product'], 'Product A'); // Verificamos que el nombre del producto sea correcto
    expect(json['results'][0]['unit_value'], 10.0); // Verificamos que el precio del producto sea correcto
  });
}