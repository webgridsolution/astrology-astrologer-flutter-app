import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/call_controller.dart';
import '../../controllers/notification_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _icon(String type) {
    switch (type) {
      case 'booking':
        return Icons.event_available_outlined;
      case 'chat':
        return Icons.chat_bubble_outline;
      case 'call':
        return Icons.videocam_outlined;
      case 'review':
        return Icons.star_outline;
      case 'payment':
        return Icons.payments_outlined;
      case 'kyc':
        return Icons.verified_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  @override
  Widget build(BuildContext context) {
    final n = context.watch<NotificationController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(onPressed: n.markAllRead, child: const Text('Mark all read')),
        ],
      ),
      body: ListView.builder(
        itemCount: n.data.notifications.length,
        itemBuilder: (_, i) {
          final item = n.data.notifications[i];
          return ListTile(
            onTap: () {
              n.markRead(item.id);
              if (item.type == 'call') {
                context.read<CallController>().startIncoming(
                      kind: CallKind.video,
                      clientId: 'c3',
                      clientName: 'Rohit Singh',
                      clientImage: AppAssets.rohit,
                    );
                Navigator.pushNamed(context, AppRoutes.incomingCall);
              } else if (item.type == 'chat') {
                Navigator.pushNamed(context, AppRoutes.chat, arguments: 'c1');
              } else if (item.type == 'booking') {
                Navigator.pushNamed(context, AppRoutes.bookings);
              }
            },
            leading: CircleAvatar(
              backgroundColor: AppColors.lavender,
              child: Icon(_icon(item.type), color: AppColors.primary),
            ),
            title: Text(item.title,
                style: TextStyle(fontWeight: item.read ? FontWeight.w500 : FontWeight.w700)),
            subtitle: Text(item.body),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat('hh:mm a').format(item.time),
                    style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                if (!item.read)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
