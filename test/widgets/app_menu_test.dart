import 'package:ccp_mobile/core/constants/app_menu.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/features/orders/views/order_view.dart';
import 'package:ccp_mobile/features/products/views/product_view.dart';
import 'package:ccp_mobile/features/clients/views/client_view.dart';
import 'package:ccp_mobile/features/settings/views/settings_view.dart';

void main() {
  group('AppMenu', () {
    test('clientMenu contains expected items', () {
      final menu = AppMenu.clientMenu;

      expect(menu.length, 3);
      expect(menu[0].icon, Icons.local_shipping);
      expect(menu[0].label, 'Pedidos');
      expect(menu[0].screen.runtimeType, OrderView);

      expect(menu[1].icon, Icons.inventory);
      expect(menu[1].label, 'Productos');
      expect(menu[1].screen.runtimeType, ProductView);

      expect(menu[2].icon, Icons.settings);
      expect(menu[2].label, 'Configuración');
      expect(menu[2].screen.runtimeType, SettingsView);
    });

    test('sellerMenu contains expected items', () {
      final menu = AppMenu.sellerMenu;

      expect(menu.length, 4);
      expect(menu[0].icon, Icons.tour);
      expect(menu[0].label, 'Pedidos');
      expect(menu[0].screen.runtimeType, OrderView);

      expect(menu[1].icon, Icons.inventory);
      expect(menu[1].label, 'Productos');
      expect(menu[1].screen.runtimeType, ProductView);

      expect(menu[2].icon, Icons.person);
      expect(menu[2].label, 'Clientes');
      expect(menu[2].screen.runtimeType, ClientView);

      expect(menu[3].icon, Icons.settings);
      expect(menu[3].label, 'Configuración');
      expect(menu[3].screen.runtimeType, SettingsView);
    });
  });
}