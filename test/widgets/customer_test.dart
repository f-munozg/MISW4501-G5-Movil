import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/customer.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('Customer constructor works correctly', () {
    final customer = Customer(
      assignedSeller: 'seller123',
      observations: 'Test observation',
      userId: 'user123',
      name: 'John Doe',
      id: '1',
      identificationNumber: 'ID12345',
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(customer.assignedSeller, 'seller123');
    expect(customer.observations, 'Test observation');
    expect(customer.userId, 'user123');
    expect(customer.name, 'John Doe');
    expect(customer.id, '1');
    expect(customer.identificationNumber, 'ID12345');
  });

  // Test 2: Verificar que fromJson convierte correctamente el mapa en un objeto Customer
  test('Customer.fromJson converts map to Customer object', () {
    final json = {
      'assigned_seller': 'seller123',
      'observations': 'Test observation',
      'user_id': 'user123',
      'name': 'John Doe',
      'id': '1',
      'identification_number': 'ID12345',
    };

    final customer = Customer.fromJson(json);

    // Verificamos que los campos del objeto Customer coincidan con el JSON
    expect(customer.assignedSeller, 'seller123');
    expect(customer.observations, 'Test observation');
    expect(customer.userId, 'user123');
    expect(customer.name, 'John Doe');
    expect(customer.id, '1');
    expect(customer.identificationNumber, 'ID12345');
  });

  // Test 3: Verificar que toJson convierte correctamente el objeto Customer en un mapa
  test('Customer.toJson converts Customer object to map', () {
    final customer = Customer(
      assignedSeller: 'seller123',
      observations: 'Test observation',
      userId: 'user123',
      name: 'John Doe',
      id: '1',
      identificationNumber: 'ID12345',
    );

    final json = customer.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['assigned_seller'], 'seller123');
    expect(json['observations'], 'Test observation');
    expect(json['user_id'], 'user123');
    expect(json['name'], 'John Doe');
    expect(json['id'], '1');
    expect(json['identification_number'], 'ID12345');
  });
}