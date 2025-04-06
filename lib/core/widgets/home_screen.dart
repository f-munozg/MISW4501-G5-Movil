import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:ccp_mobile/core/constants/app_menu.dart';
import 'package:ccp_mobile/core/models/bottom_nav_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userRole;
  const HomeScreen({super.key, required this.userRole});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<BottomNavItem> getMenuItems() {
    return widget.userRole == 'Cliente' ? AppMenu.clientMenu : AppMenu.sellerMenu; 
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getMenuItems();

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: menuItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: menuItems.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.label)).toList(),
      ),
    );
  }
}




