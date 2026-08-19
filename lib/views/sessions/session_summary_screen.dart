import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/soft_card.dart';

class SessionSummaryScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const SessionSummaryScreen({super.key, required this.args});

  @override
  State<SessionSummaryScreen> createState() => _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends State<SessionSummaryScreen> {
  final _notes = TextEditingController();

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.args['clientName'] ?? 'Client';
    final type = widget.args['type'] ?? 'Consultation';
    final duration = widget.args['duration'] ?? 28;
    final amount = widget.args['amount'] ?? 387.0;
    final clientId = widget.args['clientId'] ?? 'c1';

    return Scaffold(
      appBar: AppBar(title: const Text('Session Summary')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              children: [
                const Icon(Icons.check_circle, color: AppColors.success, size: 56),
                const SizedBox(height: 8),
                const Text('Session Completed',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(type, style: const TextStyle(color: AppColors.textMuted)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _row('Client', name),
                _row('Duration', '$duration min'),
                _row('Earnings', '₹${(amount as num).toInt()}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Private consultation notes',
            hint: 'Write notes about this session…',
            controller: _notes,
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'View Client',
            filled: false,
            onTap: () => Navigator.pushNamed(context, AppRoutes.clientDetails, arguments: clientId),
          ),
          const SizedBox(height: 10),
          AppButton(
            label: 'Done',
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashboard, (_) => false),
          ),
        ],
      ),
    );
  }

  Widget _row(String k, String v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(k, style: const TextStyle(color: AppColors.textMuted))),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ],
      ),
    );
  }
}
