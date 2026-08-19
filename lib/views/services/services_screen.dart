import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/service_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<ServiceController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Services'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.addService),
            icon: const Icon(Icons.add),
            label: const Text('Add Service'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: c.services.length,
        itemBuilder: (_, i) {
          final s = c.services[i];
          return ServiceCard(
            service: s,
            onToggle: (v) => c.toggle(s.id, v),
            onEdit: () => Navigator.pushNamed(context, AppRoutes.editService, arguments: s.id),
          );
        },
      ),
    );
  }
}
