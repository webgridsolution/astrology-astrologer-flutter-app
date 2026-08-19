import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../services/mock_data_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/booking_card.dart';
import '../../widgets/soft_card.dart';

class ClientDetailsScreen extends StatefulWidget {
  final String clientId;
  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  State<ClientDetailsScreen> createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  late final TextEditingController notes;

  @override
  void initState() {
    super.initState();
    final c = MockDataService.instance.clientById(widget.clientId);
    notes = TextEditingController(text: c?.notes ?? '');
  }

  @override
  void dispose() {
    notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = MockDataService.instance;
    final client = data.clientById(widget.clientId);
    if (client == null) {
      return const Scaffold(body: Center(child: Text('Client not found')));
    }
    final bookings = data.bookings.where((b) => b.clientId == client.id).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Client Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              children: [
                CircleAvatar(radius: 42, backgroundImage: AssetImage(client.image)),
                const SizedBox(height: 10),
                Text(client.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Text(client.mobile, style: const TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _m('${client.totalConsultations}', 'Sessions'),
                    _m('₹${client.totalSpent.toInt()}', 'Spent'),
                    _m(client.gender, 'Gender'),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Last: ${client.lastConsultation}',
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'View Kundli',
            icon: Icons.auto_awesome,
            onTap: () => Navigator.pushNamed(context, AppRoutes.clientKundli, arguments: client.id),
          ),
          const SizedBox(height: 8),
          AppButton(
            label: 'Open Chat',
            filled: false,
            onTap: () => Navigator.pushNamed(context, AppRoutes.chat, arguments: client.id),
          ),
          const SizedBox(height: 16),
          const Text('Previous bookings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          ...bookings.map((b) => BookingCard(
                booking: b,
                onTap: () => Navigator.pushNamed(context, AppRoutes.bookingDetails, arguments: b.id),
              )),
          const SizedBox(height: 8),
          const Text('Private Notes', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 6),
          const Text('Astrologer-only. Never shown to the customer app.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          AppTextField(
            label: 'Write notes about this client…',
            controller: notes,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'Save Notes',
            onTap: () {
              context.read<ProfileController>().saveNotes(client.id, notes.text.trim());
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Private notes saved')));
            },
          ),
        ],
      ),
    );
  }

  Widget _m(String v, String l) {
    return Column(
      children: [
        Text(v, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primary)),
        Text(l, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }
}
