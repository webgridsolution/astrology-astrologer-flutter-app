import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/soft_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const faqs = [
      ('How do I go online?', 'Use the Online toggle on the dashboard header to start receiving requests.'),
      ('What is the demo OTP?', 'Use 123456 to verify any mobile number in this mock build.'),
      ('How are payouts processed?', 'Request a payout from Earnings → Payouts. Mock flow credits in 1–2 days.'),
      ('Can clients see my private notes?', 'No. Private notes stay on the astrologer app only.'),
      ('How do I start a video call?', 'Open an upcoming video booking and tap Start Video Call.'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _tile(Icons.support_agent, 'Contact Support', 'care@astrochat.app'),
                _tile(Icons.report_gmailerrorred_outlined, 'Report a Problem', 'Send issue details'),
                _tile(Icons.payments_outlined, 'Payment Issues', 'Payouts & settlements'),
                _tile(Icons.video_camera_front_outlined, 'Consultation Issues', 'Chat / call / video'),
                _tile(Icons.manage_accounts_outlined, 'Account Issues', 'KYC & profile'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('FAQs', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          const SizedBox(height: 8),
          ...faqs.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SoftCard(
                  padding: EdgeInsets.zero,
                  child: ExpansionTile(
                    title: Text(f.$1, style: const TextStyle(fontWeight: FontWeight.w600)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(f.$2, style: const TextStyle(color: AppColors.textMuted)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _tile(IconData i, String t, String s) {
    return ListTile(
      leading: Icon(i, color: AppColors.primary),
      title: Text(t),
      subtitle: Text(s),
    );
  }
}
