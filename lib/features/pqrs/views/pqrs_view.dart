import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/models/pqrs.dart';
import 'package:ccp_mobile/core/services/pqrs_service.dart';
import 'package:ccp_mobile/core/utils/formatters.dart';
import 'package:ccp_mobile/features/pqrs/views/pqrs_detail_view.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';

class PqrsView extends StatefulWidget {
  const PqrsView({super.key, required this.client, required this.isClient});
  final Customer client;
  final bool isClient;

  @override
  State<PqrsView> createState() => _PqrsViewState();
}

class _PqrsViewState extends State<PqrsView> {
  late Future<List<Pqrs>?> _pqrsFuture;

  @override
  void initState() {
    super.initState();
    _loadPqrs();
  }

  void _loadPqrs() {
    setState(() {
      _pqrsFuture = PqrsService().getPqrsByCustomerId(widget.client.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "PQRS",
        showBackButton: true,
      ),
      body: FutureBuilder<List<Pqrs>?>(
        future: _pqrsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No hay prqrs realizadas por el cliente"));
          }

          final pqrsList = snapshot.data!;

          return ListView.builder(
            itemCount: pqrsList.length,
            itemBuilder: (context, index) {
              final pqrs = pqrsList[index];
              return ListTile(
                title: Text(pqrs.title, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Estado: ${parseStatus(pqrs.status)}"),
                    Text("Fecha: ${formatDateTime(pqrs.createdAt)}"), // Aquí va tu "sub-subtítulo"
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PqrsDetailView(pqrs: pqrs, isClient: widget.isClient,),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
