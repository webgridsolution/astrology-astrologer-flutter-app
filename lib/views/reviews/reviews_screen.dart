import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/review_card.dart';
import '../../widgets/soft_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProfileController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            child: Column(
              children: [
                const Text('4.9 ⭐', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                const Text('128 Reviews', style: TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 14),
                _bar('5 ★', 0.77, 98),
                _bar('4 ★', 0.16, 20),
                _bar('3 ★', 0.06, 8),
                _bar('2 ★', 0.02, 2),
                _bar('1 ★', 0.0, 0),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...p.reviews.map((r) => ReviewCard(
                review: r,
                onReply: r.reply == null
                    ? () async {
                        final ctrl = TextEditingController();
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Reply to review'),
                            content: TextField(controller: ctrl, maxLines: 3),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Send')),
                            ],
                          ),
                        );
                        if (ok == true && ctrl.text.trim().isNotEmpty) {
                          p.replyReview(r.id, ctrl.text.trim());
                        }
                      }
                    : null,
              )),
        ],
      ),
    );
  }

  Widget _bar(String label, double value, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(label, style: const TextStyle(fontSize: 12))),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              color: AppColors.gold,
              backgroundColor: AppColors.lavender,
            ),
          ),
          const SizedBox(width: 8),
          Text('$count', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
