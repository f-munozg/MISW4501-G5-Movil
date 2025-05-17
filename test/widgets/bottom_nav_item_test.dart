import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ccp_mobile/core/models/bottom_nav_item.dart';

void main() {
  // Test 1: Verificar que el constructor funciona correctamente
  test('BottomNavItem constructor works correctly', () {
    final screen = Scaffold(body: Center(child: Text('Test Screen')));
    final bottomNavItem = BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      screen: screen,
    );

    // Verificamos que todos los campos se hayan inicializado correctamente
    expect(bottomNavItem.icon, Icons.home);
    expect(bottomNavItem.label, 'Home');
    expect(bottomNavItem.screen, screen);
  });

  // Test 2: Verificar que se puede acceder al widget `screen` y verificar que es un Scaffold
  test('BottomNavItem screen is a valid widget', () {
    final screen = Scaffold(body: Center(child: Text('Test Screen')));
    final bottomNavItem = BottomNavItem(
      icon: Icons.home,
      label: 'Home',
      screen: screen,
    );

    // Verificamos que el widget screen es del tipo Scaffold
    expect(bottomNavItem.screen, isA<Scaffold>());
  });
}