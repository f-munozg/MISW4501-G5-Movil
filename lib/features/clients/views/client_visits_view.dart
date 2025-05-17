import 'package:ccp_mobile/core/models/customer.dart';
import 'package:ccp_mobile/core/services/customer_service.dart';
import 'package:ccp_mobile/features/clients/views/client_route_detail_view.dart';
import 'package:ccp_mobile/features/clients/views/register_visit_view.dart';
import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/widgets/custom_app_bar.dart';
import 'package:ccp_mobile/core/constants/app_colors.dart';

class ClientVisitsView extends StatefulWidget {
  final Customer client;
  const ClientVisitsView({super.key, required this.client});

  @override
  State<ClientVisitsView> createState() => _ClientVisitsViewState();
}

class _ClientVisitsViewState extends State<ClientVisitsView> {
  List<Map<String, dynamic>> previousVisits = [];
  List<Map<String, dynamic>> suggestedVisits = [];
  Map<String, dynamic> responseVisits = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomerVisits();
  }

  Future<void> _loadCustomerVisits() async {
    try {
      final response =
          await CustomerService().getCustomerVisits(widget.client.id);
      responseVisits = response;

      if (response != null && response['stops'] is List) {
        final stops = List<Map<String, dynamic>>.from(response['stops']);

        setState(() {
          previousVisits =
              stops.where((stop) => stop['status'] != 'PENDIENTE').toList();
          suggestedVisits =
              stops.where((stop) => stop['status'] == 'PENDIENTE').toList();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Visitas",
        showBackButton: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          String? eta;
                          if (suggestedVisits.isNotEmpty) {
                            final rawEta = suggestedVisits[0]['eta'];
                            eta = rawEta?.toString();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientRouteDetailView(
                                eta: eta,
                                routeMap: responseVisits['route_map'],
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.map),
                            SizedBox(width: 8),
                            Text(
                              "Ver Ruta",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      if (suggestedVisits.isNotEmpty)
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RegisterVisitView(client: widget.client),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(color: AppColors.primaryColor),
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text("Crear visita",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...previousVisits.map((visit) => _visitItem(visit)),
                  const SizedBox(height: 24),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text("RUTA SUGERIDA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  ...(suggestedVisits.isEmpty
                      ? [
                          const Center(
                            child: Text(
                              "No tiene visitas pendientes.",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        ]
                      : suggestedVisits
                          .map((visit) => _visitItem(visit))
                          .toList()),
                ],
              ),
            ),
    );
  }

  Widget _visitItem(Map<String, dynamic> visit) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (visit['result'] != null)
                    Text(
                      "Resultado: ${visit['result']}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  Text("Observaciones:",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  if (visit['observations'] == null)
                    Text(
                      "Visita por realizar",
                      style: const TextStyle(fontSize: 12),
                    ),
                  if (visit['observations'] != null)
                    Text(
                      "${visit['observations']}",
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
            ),
            Text(
              visit['status'] ?? 'Sin estado',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1),
      ],
    );
  }
}
