import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/store.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('Store constructor works correctly', () {
    final store = Store(
      id: '1',
      identificationNumber: '12345',
      address: '123 Street',
      phone: '555-5555',
      country: 'Country1',
      city: 'City1',
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(store.id, '1');
    expect(store.identificationNumber, '12345');
    expect(store.address, '123 Street');
    expect(store.phone, '555-5555');
    expect(store.country, 'Country1');
    expect(store.city, 'City1');
  });

  // Test 2: Verificar que fromJson convierte correctamente el mapa en un objeto Store
  test('Store.fromJson converts map to Store object', () {
    final json = {
      'id': '1',
      'identification_number': '12345',
      'address': '123 Street',
      'phone': '555-5555',
      'country': 'Country1',
      'city': 'City1',
    };

    final store = Store.fromJson(json);

    // Verificamos que los campos del objeto Store coincidan con el JSON
    expect(store.id, '1');
    expect(store.identificationNumber, '12345');
    expect(store.address, '123 Street');
    expect(store.phone, '555-5555');
    expect(store.country, 'Country1');
    expect(store.city, 'City1');
  });

  // Test 3: Verificar que toJson convierte correctamente el objeto Store en un mapa
  test('Store.toJson converts Store object to map', () {
    final store = Store(
      id: '1',
      identificationNumber: '12345',
      address: '123 Street',
      phone: '555-5555',
      country: 'Country1',
      city: 'City1',
    );

    final json = store.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['id'], '1');
    expect(json['identification_number'], '12345');
    expect(json['address'], '123 Street');
    expect(json['phone'], '555-5555');
    expect(json['country'], 'Country1');
    expect(json['city'], 'City1');
  });
}