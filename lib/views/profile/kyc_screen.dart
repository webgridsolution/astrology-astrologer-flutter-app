import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/soft_card.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StatusTile(title: 'Profile Verification', status: 'Approved'),
          _StatusTile(title: 'Documents', status: 'Verified'),
          _StatusTile(title: 'Bank Account', status: 'Verified'),
          SizedBox(height: 12),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sections', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 10),
                _Line(icon: Icons.badge_outlined, label: 'Personal Information', done: true),
                _Line(icon: Icons.credit_card, label: 'Government ID', done: true),
                _Line(icon: Icons.photo_camera_outlined, label: 'Profile Photo', done: true),
                _Line(icon: Icons.workspace_premium_outlined, label: 'Astrology Certification', done: true),
                _Line(icon: Icons.account_balance_outlined, label: 'Bank Details', done: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  final String title;
  final String status;
  const _StatusTile({required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SoftCard(
        child: Row(
          children: [
            const Icon(Icons.verified, color: AppColors.success),
            const SizedBox(width: 10),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
            Text(status, style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool done;
  const _Line({required this.icon, required this.label, required this.done});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: Icon(done ? Icons.check_circle : Icons.hourglass_bottom,
          color: done ? AppColors.success : AppColors.warning),
    );
  }
}
