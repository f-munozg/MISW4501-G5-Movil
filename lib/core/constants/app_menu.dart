import '../../features/store/views/store_view.dart';
import '../../features/clients/views/client_view.dart';
import '../../features/orders/views/order_view.dart';
import '../../features/settings/views/settings_view.dart';
import '../../features/stock/views/stock_view.dart';
import 'package:flutter/material.dart';
import '../../features/products/views/product_view.dart';

class AppMenu {
  static final List<BottomNavItem> clientMenu = [
    BottomNavItem(icon: Icons.local_shipping, label: 'Pedidos', screen: const OrderView()),
    BottomNavItem(icon: Icons.inventory, label: 'Productos', screen: const ProductView()),
    BottomNavItem(icon: Icons.storefront, label: 'Stock',screen: const StockView()),
    BottomNavItem(icon: Icons.settings, label: 'Configuración', screen: const SettingsView()),
  ];

  static final List<BottomNavItem> sellerMenu = [
    BottomNavItem(icon: Icons.tour, label: 'Inicio', screen: const OrderView()),
    BottomNavItem(icon: Icons.inventory, label: 'Productos', screen: const ProductView()),
    BottomNavItem(icon: Icons.storefront, label: 'Tiendas', screen: const StoreView()),
    BottomNavItem(icon: Icons.person, label: 'Clientes', screen: const ClientView()),
    BottomNavItem(icon: Icons.settings, label: 'Configuración', screen: const SettingsView()),
  ];
}

class BottomNavItem {
  final IconData icon;
  final String label;
  final Widget screen;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}