import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class EarningsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color tint;

  const EarningsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.tint = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Expanded(
                child: Text(title,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ),
              Icon(icon, color: tint, size: 20),
            ],
          ),
          const SizedBox(height: 10),
          Text(value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: tint)),
          if (subtitle != null)
            Text(subtitle!, style: const TextStyle(color: AppColors.textLight, fontSize: 11)),
        ],
      ),
    );
  }
}
