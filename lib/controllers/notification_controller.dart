import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';

class NotificationController extends ChangeNotifier {
  final data = MockDataService.instance;

  int get unreadCount => data.notifications.where((n) => !n.read).length;

  void markAllRead() {
    for (var i = 0; i < data.notifications.length; i++) {
      data.notifications[i] = data.notifications[i].copyWith(read: true);
    }
    notifyListeners();
  }

  void markRead(String id) {
    final i = data.notifications.indexWhere((n) => n.id == id);
    if (i >= 0) {
      data.notifications[i] = data.notifications[i].copyWith(read: true);
      notifyListeners();
    }
  }
}
