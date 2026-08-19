import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/soft_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _t(context, Icons.schedule, 'Availability', AppRoutes.availability),
                _t(context, Icons.notifications_active_outlined, 'Notification Settings',
                    AppRoutes.notificationSettings),
                _t(context, Icons.person_outline, 'Profile Settings', AppRoutes.editProfile),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: AppColors.primary),
                  title: const Text('Change Password'),
                  subtitle: const Text('OTP login is used. Password is not required.'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This account uses OTP. No password needed.')),
                    );
                  },
                ),
                _t(context, Icons.privacy_tip_outlined, 'Privacy Policy', AppRoutes.privacy),
                _t(context, Icons.description_outlined, 'Terms & Conditions', AppRoutes.terms),
                _t(context, Icons.help_outline, 'Help & Support', AppRoutes.help),
                _t(context, Icons.info_outline, 'About AstroChat', AppRoutes.about),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _t(BuildContext context, IconData i, String t, String r) {
    return ListTile(
      leading: Icon(i, color: AppColors.primary),
      title: Text(t),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, r),
    );
  }
}

class SimpleInfoScreen extends StatelessWidget {
  final String title;
  final String body;
  const SimpleInfoScreen({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(body, style: const TextStyle(height: 1.5, color: AppColors.textDark)),
      ),
    );
  }
}

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        children: const [
          SwitchListTile(value: true, onChanged: null, title: Text('New bookings')),
          SwitchListTile(value: true, onChanged: null, title: Text('Chat messages')),
          SwitchListTile(value: true, onChanged: null, title: Text('Incoming calls')),
          SwitchListTile(value: true, onChanged: null, title: Text('Payments')),
          SwitchListTile(value: false, onChanged: null, title: Text('Marketing')),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About AstroChat')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(AppAssets.logo, width: 88, height: 88, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            const Text('AstroChat Astrologer',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const Text('Astrologer Partner App  ·  v1.0.0'),
            const SizedBox(height: 16),
            const Text(
              'A premium partner console for astrologers to manage consultations, clients, earnings and availability.',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            const Text(AppConstants.poweredBy,
                style: TextStyle(letterSpacing: 1.2, color: AppColors.textLight)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
