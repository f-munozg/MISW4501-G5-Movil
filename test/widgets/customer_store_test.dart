import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/store.dart';
import 'package:ccp_mobile/core/models/customer_store.dart';

void main() {
  group('CustomerWithStore', () {
    final customerJson = {
      'assigned_seller': 'seller_123',
      'observations': 'Frequent buyer',
      'user_id': 'user_456',
      'name': 'John Doe',
      'id': 'cust_789',
      'identification_number': 'ID12345',
    };

    final storeJson = {
      'id': 'store_001',
      'identification_number': 'STORE-ID-99',
      'address': '123 Main St',
      'phone': '+1234567890',
      'country': 'USA',
      'city': 'New York',
    };

    final customerWithStoreJson = {
      'customer': customerJson,
      'store': storeJson,
    };

    test('fromJson should correctly parse CustomerWithStore object', () {
      final customerWithStore = CustomerWithStore.fromJson(customerWithStoreJson);

      expect(customerWithStore.customer.id, 'cust_789');
      expect(customerWithStore.customer.name, 'John Doe');
      expect(customerWithStore.customer.userId, 'user_456');
      expect(customerWithStore.store.id, 'store_001');
      expect(customerWithStore.store.city, 'New York');
    });

    test('toJson should return correct map', () {
      final customer = Customer.fromJson(customerJson);
      final store = Store.fromJson(storeJson);
      final customerWithStore = CustomerWithStore(customer: customer, store: store);

      final json = customerWithStore.toJson();

      expect(json, customerWithStoreJson);
    });
  });
}