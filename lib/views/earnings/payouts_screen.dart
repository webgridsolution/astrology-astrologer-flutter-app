import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/earnings_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/app_button.dart';
import '../../widgets/earnings_card.dart';
import '../../widgets/soft_card.dart';

class PayoutsScreen extends StatelessWidget {
  const PayoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final e = context.watch<EarningsController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Payouts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: EarningsCard(
                    title: 'Available', value: '₹${e.available.toInt()}', icon: Icons.savings_outlined),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: EarningsCard(
                    title: 'Pending',
                    value: '₹${e.pending.toInt()}',
                    icon: Icons.hourglass_bottom,
                    tint: AppColors.warning),
              ),
            ],
          ),
          const SizedBox(height: 10),
          EarningsCard(
              title: 'Total Paid',
              value: '₹${e.paid.toInt()}',
              icon: Icons.verified_outlined,
              tint: AppColors.success),
          const SizedBox(height: 16),
          AppButton(
            label: 'Request Payout',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payout request submitted (mock).')),
              );
            },
          ),
          const SizedBox(height: 18),
          const Text('Payout History', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          ...e.data.payouts.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SoftCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('₹${p.amount.toInt()}',
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                            Text('${DateFormat('d MMM yyyy').format(p.date)} · ${p.method}',
                                style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                      Text(p.status,
                          style: TextStyle(
                            color: p.status == 'Paid' ? AppColors.success : AppColors.warning,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
