import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/earnings_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/soft_card.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final e = context.watch<EarningsController>();
    const filters = ['Today', 'Week', 'Month', 'Year'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Earnings'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.payouts),
            child: const Text('Payouts'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SoftCard(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Earnings', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                Text('₹${e.total.toInt()}',
                    style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: filters.map((f) {
              final selected = e.filter == f;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ChoiceChip(
                    label: Center(child: Text(f)),
                    selected: selected,
                    onSelected: (_) => e.setFilter(f),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: selected ? Colors.white : AppColors.textDark, fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          SoftCard(
            child: Column(
              children: [
                _line('Chat Earnings', e.chat),
                _line('Audio Call Earnings', e.audio),
                _line('Other Services', e.other),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Transactions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          ...e.data.transactions.map((t) => SoftCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.successSoft,
                      child: Icon(Icons.south_west, color: AppColors.success, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text(DateFormat('d MMM, hh:mm a').format(t.date),
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    Text('+₹${t.amount.toInt()}',
                        style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _line(String k, double v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(k)),
          Text('₹${v.toInt()}', style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
