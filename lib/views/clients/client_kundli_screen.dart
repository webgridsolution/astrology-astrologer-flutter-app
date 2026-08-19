import 'package:flutter/material.dart';
import '../../services/mock_data_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/soft_card.dart';

class ClientKundliScreen extends StatelessWidget {
  final String clientId;
  const ClientKundliScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    final client = MockDataService.instance.clientById(clientId);
    if (client == null) {
      return const Scaffold(body: Center(child: Text('Client not found')));
    }
    final k = client.kundli;

    return Scaffold(
      appBar: AppBar(title: Text("${client.name}'s Kundli")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Row(
              children: [
                CircleAvatar(radius: 28, backgroundImage: AssetImage(client.image)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(client.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      Text('${k.dateOfBirth}  ·  ${k.timeOfBirth}',
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                      Text(k.placeOfBirth, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(AppAssets.kundli, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _row('Rashi', k.rashi),
                _row('Nakshatra', k.nakshatra),
                _row('Lagna', k.lagna),
                _row('Sun Sign', k.sunSign),
                _row('Moon Sign', k.moonSign),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Planetary Positions', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                ...k.planets.entries.map((e) => _row(e.key, e.value)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(child: Text(a, style: const TextStyle(color: AppColors.textMuted))),
          Flexible(child: Text(b, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
