import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/review_model.dart';
import '../utils/app_colors.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final VoidCallback? onReply;

  const ReviewCard({super.key, required this.review, this.onReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0C2B1A6B), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundImage: AssetImage(review.clientImage)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.clientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(DateFormat('d MMM yyyy').format(review.date),
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating.round() ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 16,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(review.comment, style: const TextStyle(height: 1.4)),
          if (review.reply != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lavender,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('You: ${review.reply}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textDark)),
            ),
          ] else if (onReply != null)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: onReply, child: const Text('Reply')),
            ),
        ],
      ),
    );
  }
}
