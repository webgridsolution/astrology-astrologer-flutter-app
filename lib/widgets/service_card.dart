import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../utils/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final ValueChanged<bool> onToggle;
  final VoidCallback onEdit;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onToggle,
    required this.onEdit,
  });

  IconData get _icon {
    switch (service.icon) {
      case 'call':
        return Icons.call_outlined;
      case 'video':
        return Icons.videocam_outlined;
      case 'kundli':
        return Icons.auto_awesome;
      case 'tarot':
        return Icons.style_outlined;
      case 'love':
        return Icons.favorite_outline;
      default:
        return Icons.chat_bubble_outline;
    }
  }

  Color get _tint {
    switch (service.icon) {
      case 'call':
        return AppColors.primary;
      case 'video':
        return const Color(0xFF7C3AED);
      case 'kundli':
        return AppColors.danger;
      case 'tarot':
        return AppColors.orange;
      case 'love':
        return AppColors.pink;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0C2B1A6B), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _tint.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_icon, color: _tint),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(service.priceLabel,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
          Switch.adaptive(
            value: service.enabled,
            activeColor: AppColors.primary,
            onChanged: onToggle,
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }
}
