import 'package:ccp_mobile/core/models/customer_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/store.dart';

void main() {
  group('CustomerWithStore', () {
    final customerJson = {
      'assigned_seller': 'seller123',
      'observations': 'Regular customer',
      'user_id': 'user456',
      'name': 'John Doe',
      'id': 'cust001',
      'identification_number': '1234567890',
    };

    final storeJson = {
      'id': 'store001',
      'identification_number': '0987654321',
      'address': '123 Main St',
      'phone': '555-1234',
      'country': 'Wonderland',
      'city': 'Fantasy City',
    };

    test('fromJson should create a valid instance', () {
      final json = {
        'customer': customerJson,
        'store': storeJson,
      };

      final instance = CustomerWithStore.fromJson(json);

      expect(instance.customer.name, 'John Doe');
      expect(instance.customer.userId, 'user456');
      expect(instance.store.address, '123 Main St');
      expect(instance.store.city, 'Fantasy City');
    });

    test('toJson should return a valid map', () {
      final customer = Customer.fromJson(customerJson);
      final store = Store.fromJson(storeJson);

      final customerWithStore = CustomerWithStore(
        customer: customer,
        store: store,
      );

      final json = customerWithStore.toJson();

      expect(json['customer'], customerJson);
      expect(json['store'], storeJson);
    });
  });
}