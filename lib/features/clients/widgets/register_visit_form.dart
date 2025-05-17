import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:flutter/material.dart';

class RegisterVisitForm extends StatefulWidget {
  final Customer client;
  final CustomerService customerService = CustomerService();
  RegisterVisitForm({super.key, required this.client});

  @override
  State<RegisterVisitForm> createState() => _RegisterVisitFormState();
}

class _RegisterVisitFormState extends State<RegisterVisitForm> {
  bool visitaRealizada = true;
  bool tipoOrdenP = true;
  final TextEditingController observacionesController = TextEditingController();

  @override
  void dispose() {
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _infoRow("Nombre:", widget.client.name ?? "N/A"),
              _infoRow("Dirección:", "Calle 50 Carrera 100"),
              _infoRow("CC:", widget.client.identificationNumber ?? "N/A"),
              const SizedBox(height: 20),
              const Text("Visita:", style: TextStyle(fontWeight: FontWeight.w600)),
              _toggleOption("Realizada", visitaRealizada, () {
                setState(() {
                  visitaRealizada = true;
                });
              }),
              _toggleOption("No Realizada", !visitaRealizada, () {
                setState(() {
                  visitaRealizada = false;
                });
              }),
              const SizedBox(height: 12),
              const Text("Tipo Orden:", style: TextStyle(fontWeight: FontWeight.w600)),
              _toggleOption("Pedido", tipoOrdenP, () {
                setState(() {
                  tipoOrdenP = true;
                });
              }),
              _toggleOption("Reserva", !tipoOrdenP, () {
                setState(() {
                  tipoOrdenP = false;
                });
              }),
              const SizedBox(height: 20),
              const Text("Observaciones", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                key: const Key('observacionesField'),
                controller: observacionesController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  key: const Key('registerVisitButton'),
                  onPressed: () async {
                    final customerId = widget.client.id;
                    final observations = observacionesController.text.trim();

                    if (observations.isEmpty) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Por favor ingrese una observación')),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(child: CircularProgressIndicator()),
                    );

                    final success = await widget.customerService.registerVisit(
                      customerId,
                      observations,
                      visitaRealizada,
                      tipoOrdenP,
                    );


                    if (!mounted) return;

                    Navigator.of(context).pop(); 

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Visita registrada exitosamente')),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al registrar la visita')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF00695C),
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Color(0xFF00695C), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Registrar",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  Widget _toggleOption(String text, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(child: Text(text)),
            CircleAvatar(
              radius: 14,
              backgroundColor: selected ? Colors.green : Colors.grey.shade300,
              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}