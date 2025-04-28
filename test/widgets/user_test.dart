import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/user.dart';

void main() {
  // 1. Verificar que el constructor funciona correctamente
  test('User constructor works correctly', () {
    final user = User(
      identificationNumber: '12345',
      name: 'John Doe',
      address: '123 Street',
      countries: ['Country1', 'Country2'],
      identificationNumberContact: '54321',
      nameContact: 'Jane Doe',
      phoneContact: '555-5555',
      addressContact: '456 Avenue',
    );

    // Verificamos que todos los campos del constructor estén correctamente inicializados
    expect(user.identificationNumber, '12345');
    expect(user.name, 'John Doe');
    expect(user.address, '123 Street');
    expect(user.countries, ['Country1', 'Country2']);
    expect(user.identificationNumberContact, '54321');
    expect(user.nameContact, 'Jane Doe');
    expect(user.phoneContact, '555-5555');
    expect(user.addressContact, '456 Avenue');
  });

  // 2. Verificar que fromJson convierte correctamente el mapa en un objeto User
  test('User.fromJson converts map to User object', () {
    final json = {
      'identification_number': '12345',
      'name': 'John Doe',
      'address': '123 Street',
      'countries': ['Country1', 'Country2'],
      'identification_number_contact': '54321',
      'name_contact': 'Jane Doe',
      'phone_contact': '555-5555',
      'address_contact': '456 Avenue',
    };

    final user = User.fromJson(json);

    // Verificamos que los campos del objeto User coincidan con el JSON
    expect(user.identificationNumber, '12345');
    expect(user.name, 'John Doe');
    expect(user.address, '123 Street');
    expect(user.countries, ['Country1', 'Country2']);
    expect(user.identificationNumberContact, '54321');
    expect(user.nameContact, 'Jane Doe');
    expect(user.phoneContact, '555-5555');
    expect(user.addressContact, '456 Avenue');
  });

  // 3. Verificar que toJson convierte correctamente el objeto User en un mapa
  test('User.toJson converts User object to map', () {
    final user = User(
      identificationNumber: '12345',
      name: 'John Doe',
      address: '123 Street',
      countries: ['Country1', 'Country2'],
      identificationNumberContact: '54321',
      nameContact: 'Jane Doe',
      phoneContact: '555-5555',
      addressContact: '456 Avenue',
    );

    final json = user.toJson();

    // Verificamos que el mapa generado por toJson coincida con lo esperado
    expect(json['identification_number'], '12345');
    expect(json['name'], 'John Doe');
    expect(json['address'], '123 Street');
    expect(json['countries'], ['Country1', 'Country2']);
    expect(json['identification_number_contact'], '54321');
    expect(json['name_contact'], 'Jane Doe');
    expect(json['phone_contact'], '555-5555');
    expect(json['address_contact'], '456 Avenue');
  });
}