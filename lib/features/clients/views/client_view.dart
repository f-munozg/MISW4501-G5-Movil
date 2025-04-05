import 'package:ccp_mobile/core/models/user.dart';
import 'package:ccp_mobile/features/clients/views/client_detail_view.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class ClientView extends StatelessWidget {
  ClientView({super.key});

  final List<User> clients = [
    User(
      identificationNumber: "123456789",
      name: "John Doe",
      address: "Calle 80",
      countries: ["Colombia", "EEUU"],
      identificationNumberContact: "987654321",
      nameContact: "Jane Doe",
      phoneContact: "3213211203",
      addressContact: "Calle 81",
    ),
    User(
      identificationNumber: "987654321",
      name: "Alice Smith",
      address: "Calle 90",
      countries: ["España", "Argentina"],
      identificationNumberContact: "123123123",
      nameContact: "Bob Smith",
      phoneContact: "555555555",
      addressContact: "Calle 91",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Clientes",
        showBackButton: false,
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          final client = clients[index];
          return ListTile(
            leading: CircleAvatar(child: Text(client.name[0])),
            title: Text(client.name),
            subtitle: Text(client.address),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientDetailView(client: client),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
