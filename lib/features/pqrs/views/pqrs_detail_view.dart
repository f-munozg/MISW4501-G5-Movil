import 'package:ccp_mobile/core/models/pqrs.dart';
import 'package:ccp_mobile/core/services/pqrs_service.dart';
import 'package:ccp_mobile/core/utils/formatters.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PqrsDetailView extends StatefulWidget {
  final Pqrs pqrs;
  final bool? isClient;

  const PqrsDetailView({super.key, required this.pqrs, required this.isClient});
  @override
  State<PqrsDetailView> createState() => _PqrsDetailViewState();
}

class _PqrsDetailViewState extends State<PqrsDetailView> {
  bool _loading = false;


  void _handleResponse() async {
    setState(() => _loading = true);
    try {
      final success = await PqrsService().updatePqrs(
        pqrsId: widget.pqrs.id,
        status: "resuelta",
        orderId: widget.pqrs.orderId ?? '',
      );

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          success == true
              ? 'PQRS actualizada como resuelta.'
              : 'Acceso no autorizado.',
        ),
        backgroundColor: success == true ? Colors.green : Colors.orange,
      ));
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al actualizar PQRS: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pqrs = widget.pqrs;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalle PQRS',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Container(
            height: 8,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00B37A), Color(0xFF8CD790)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'PQR',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      pqrs.id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Fecha de creación: ${formatDateTime(pqrs.createdAt)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Título: ${pqrs.title}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Observaciones:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(pqrs.description, textAlign: TextAlign.justify),
                  const SizedBox(height: 32),
                  if(widget.isClient == false && widget.pqrs.status != 'cerrado')
                  Center(
                    child: ElevatedButton(
                      onPressed: _loading ? null : _handleResponse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00946E),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Responder',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
