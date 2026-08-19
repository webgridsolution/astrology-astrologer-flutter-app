import 'package:flutter/material.dart';
import '../models/client_model.dart';
import '../utils/app_colors.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;
  final VoidCallback? onTap;

  const ClientCard({super.key, required this.client, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: CircleAvatar(radius: 24, backgroundImage: AssetImage(client.image)),
      title: Text(client.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        '${client.totalConsultations} consultations  ·  ₹${client.totalSpent.toInt()}',
        style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
    );
  }
}
