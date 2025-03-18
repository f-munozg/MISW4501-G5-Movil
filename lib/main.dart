import 'package:ccp_mobile/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'features/products/views/product_view.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userRole;
  const HomeScreen({Key? key, required this.userRole}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<BottomNavItem> getMenuItems() {
    return widget.userRole == 'admin'
        ? [
            BottomNavItem(icon: Icons.local_shipping, label: 'Pedidos', screen: const ProductView(), showBackButton: false, actionButton: null),
            BottomNavItem(icon: Icons.inventory, label: 'Productos', screen: const ProductView(), showBackButton: true, actionButton: IconButton(icon: Icon(Icons.add), onPressed: () {})),
            BottomNavItem(icon: Icons.storefront, label: 'Stock', screen: const ProductView(), showBackButton: true, actionButton: null),
            BottomNavItem(icon: Icons.settings, label: 'Configuración', screen: const ProductView(), showBackButton: true, actionButton: null),
          ]
        : [
            BottomNavItem(icon: Icons.tour, label: 'Inicio', screen: const ProductView(), showBackButton: false, actionButton: null),
            BottomNavItem(icon: Icons.inventory, label: 'Productos', screen: const ProductView(), showBackButton: true, actionButton: IconButton(icon: Icon(Icons.add), onPressed: () {})),
            BottomNavItem(icon: Icons.storefront, label: 'Tiendas', screen: const ProductView(), showBackButton: true, actionButton: null),
            BottomNavItem(icon: Icons.person, label: 'Clientes', screen: const ProductView(), showBackButton: true, actionButton: null),
            BottomNavItem(icon: Icons.settings, label: 'Configuración', screen: const ProductView(), showBackButton: true, actionButton: null),
          ];
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = getMenuItems();
    final currentItem = menuItems[_selectedIndex];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(currentItem.label, style: const TextStyle(color: Colors.white)),
          centerTitle: true,
          leading: currentItem.showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => setState(() {
                    _selectedIndex = 0; // Regresa al home
                  }),
                )
              : null,
          actions: currentItem.actionButton != null ? [currentItem.actionButton!] : [],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: menuItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: menuItems.map((item) => BottomNavigationBarItem(icon: Icon(item.icon), label: item.label)).toList(),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;
  final Widget screen;
  final bool showBackButton;
  final Widget? actionButton;

  BottomNavItem({
    required this.icon,
    required this.label,
    required this.screen,
    this.showBackButton = false,
    this.actionButton,
  });
}



