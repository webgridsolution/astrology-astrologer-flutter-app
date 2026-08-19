import '../models/notification_model.dart';

final mockNotifications = <NotificationModel>[
  NotificationModel(
    id: 'n1',
    title: 'New booking received',
    body: 'Aman Verma booked a Chat Session at 10:00 AM.',
    time: DateTime(2026, 8, 18, 9, 10),
    type: 'booking',
  ),
  NotificationModel(
    id: 'n2',
    title: 'Aman Verma started a chat',
    body: 'New unread messages in Chat.',
    time: DateTime(2026, 8, 18, 10, 26),
    type: 'chat',
  ),
  NotificationModel(
    id: 'n3',
    title: 'Incoming video call',
    body: 'Rohit Singh is calling you for a video consultation.',
    time: DateTime(2026, 8, 18, 12, 58),
    type: 'call',
  ),
  NotificationModel(
    id: 'n4',
    title: 'New review received',
    body: 'Aman Verma rated you 5 stars.',
    time: DateTime(2026, 8, 15, 19, 20),
    type: 'review',
    read: true,
  ),
  NotificationModel(
    id: 'n5',
    title: 'Payment received',
    body: '₹474 credited for Call with Priya.',
    time: DateTime(2026, 8, 18, 11, 52),
    type: 'payment',
    read: true,
  ),
  NotificationModel(
    id: 'n6',
    title: 'Session reminder',
    body: 'Video call with Rohit Singh starts at 1:00 PM.',
    time: DateTime(2026, 8, 18, 12, 45),
    type: 'session',
  ),
  NotificationModel(
    id: 'n7',
    title: 'Verification approved',
    body: 'Your KYC and bank details are verified.',
    time: DateTime(2026, 8, 2, 11, 0),
    type: 'kyc',
    read: true,
  ),
];
