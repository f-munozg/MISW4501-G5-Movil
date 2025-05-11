import 'package:ccp_mobile/core/models/order.dart';
import 'package:ccp_mobile/core/services/order_service.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_create_view.dart';
import 'package:flutter/material.dart';

class OrderDetailProductView extends StatefulWidget {
  final String orderId;

  const OrderDetailProductView({super.key, required this.orderId});

  @override
  State<OrderDetailProductView> createState() => _OrderDetailProductViewState();
}

class _OrderDetailProductViewState extends State<OrderDetailProductView> {
  final orderService = OrderService();
  Order? order;
  // TODO Convert to true on production
  bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadOrder();
  // }

  // Future<void> _loadOrder() async {
  //   try {
  //     final fetchedOrder = await orderService.getOrdersById(widget.orderId);
  //     setState(() {
  //       order = fetchedOrder;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error al cargar pedido: $e')),
  //     );
  //   }
  // }

  final productos = List.generate(4, (index) => 'Lorem Ipsum');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Detalle de pedido",
        showBackButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  ...productos.map((p) => _productoItem()).toList(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PqrsCreateView()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      foregroundColor: const Color(0xFF2E7055),
                      side: const BorderSide(
                          color: Color(0xFF2E7055), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Crear PQRS"),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _productoItem() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Lorem Ipsum",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text("Fabricante: XXX"),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Cantidad: XXX"),
              ],
            ),
          ],
        ),
        const Divider(height: 24, thickness: 1),
      ],
    );
  }
}


// import 'package:ccp_mobile/core/models/order.dart';
// import 'package:ccp_mobile/core/services/order_service.dart';
// import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
// import 'package:flutter/material.dart';

// class OrderDetailProductView extends StatefulWidget {
//   final String orderId;

//   const OrderDetailProductView({super.key, required this.orderId});

//   @override
//   State<OrderDetailProductView> createState() => _OrderDetailProductViewState();
// }

// class _OrderDetailProductViewState extends State<OrderDetailProductView> {
//   final orderService = OrderService();
//   Order? order;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadOrder();
//   }

//   Future<void> _loadOrder() async {
//     try {
//       final fetchedOrder = await orderService.getOrdersById(widget.orderId);
//       setState(() {
//         order = fetchedOrder;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error al cargar pedido: $e')),
//       );
//     }
//   }

//   void pickImage() {
//     // Lógica para cargar comprobante
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Detalle de pedido",
//         showBackButton: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: ListView(
//                 children: [
//                   const SizedBox(height: 16),
//                   if (order != null && order!.products.isNotEmpty)
//                     ...order!.products.map((product) => _productoItem(product)).toList()
//                   else
//                     const Text('No hay productos en este pedido.'),
//                   const SizedBox(height: 24),
//                   OutlinedButton(
//                     onPressed: pickImage,
//                     style: OutlinedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                       foregroundColor: const Color(0xFF2E7055),
//                       side: const BorderSide(color: Color(0xFF2E7055), width: 2),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text("Cargar comprobante de pago"),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _productoItem(product) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(product.name ?? "Producto", style: const TextStyle(fontWeight: FontWeight.w500)),
//                   const SizedBox(height: 4),
//                   Text("Fabricante: ${product.manufacturer ?? 'N/A'}"),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text("Cantidad: ${product.quantity ?? 'N/A'}"),
//                 const SizedBox(height: 4),
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundColor: const Color(0xFF00695C),
//                   child: const Icon(Icons.add, color: Colors.white, size: 20),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const Divider(height: 24, thickness: 1),
//       ],
//     );
//   }
// }
