import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/notification_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/soft_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AuthController>().astrologer;
    final unread = context.watch<NotificationController>().unreadCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SoftCard(
            onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
            child: Row(
              children: [
                CircleAvatar(radius: 28, backgroundImage: AssetImage(a.image)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      Text(a.title, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SoftCard(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                _item(context, Icons.person_outline, 'Profile', AppRoutes.profile),
                _item(context, Icons.miscellaneous_services_outlined, 'Services', AppRoutes.services),
                _item(context, Icons.star_outline, 'Reviews', AppRoutes.reviews),
                _item(context, Icons.schedule, 'Availability', AppRoutes.availability),
                _item(context, Icons.groups_outlined, 'Clients', AppRoutes.clients),
                _item(context, Icons.videocam_outlined, 'Sessions', AppRoutes.sessions),
                _item(context, Icons.notifications_none, 'Notifications', AppRoutes.notifications,
                    badge: unread),
                _item(context, Icons.verified_outlined, 'KYC / Verification', AppRoutes.kyc),
                _item(context, Icons.settings_outlined, 'Settings', AppRoutes.settings),
                _item(context, Icons.help_outline, 'Help & Support', AppRoutes.help),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.danger),
                  title: const Text('Logout', style: TextStyle(color: AppColors.danger)),
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(AppConstants.poweredBy,
                style: TextStyle(color: AppColors.textLight, fontSize: 11, letterSpacing: 1.1)),
          ),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String label, String route, {int badge = 0}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(color: AppColors.danger, borderRadius: BorderRadius.circular(10)),
              child: Text('$badge', style: const TextStyle(color: Colors.white, fontSize: 11)),
            ),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }

  Future<void> _logout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await context.read<AuthController>().logout();
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }
}
