import 'package:flutter/material.dart';
import '../models/chat_message_model.dart';
import '../services/mock_data_service.dart';

class ChatController extends ChangeNotifier {
  final data = MockDataService.instance;
  String tab = 'All';

  List<ChatThreadModel> get threads {
    switch (tab) {
      case 'Unread':
        return data.threads.where((t) => t.unread > 0).toList();
      case 'Starred':
        return data.threads.where((t) => t.starred).toList();
      default:
        return data.threads;
    }
  }

  void setTab(String value) {
    tab = value;
    notifyListeners();
  }

  List<ChatMessageModel> messagesFor(String chatId) {
    return data.messages[chatId] ?? [];
  }

  void send(String chatId, String text) {
    if (text.trim().isEmpty) return;
    final list = data.messages.putIfAbsent(chatId, () => []);
    list.add(ChatMessageModel(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      chatId: chatId,
      senderId: 'ast-1',
      isAstrologer: true,
      text: text.trim(),
      time: DateTime.now(),
    ));
    notifyListeners();
  }
}
