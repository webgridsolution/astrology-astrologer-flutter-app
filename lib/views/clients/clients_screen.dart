import 'package:flutter/material.dart';
import '../../services/mock_data_service.dart';
import '../../utils/constants.dart';
import '../../widgets/client_card.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = MockDataService.instance.clients;
    return Scaffold(
      appBar: AppBar(title: const Text('Clients')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: clients.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final c = clients[i];
          return ClientCard(
            client: c,
            onTap: () => Navigator.pushNamed(context, AppRoutes.clientDetails, arguments: c.id),
          );
        },
      ),
    );
  }
}
