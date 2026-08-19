class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final bool isAstrologer;
  final String text;
  final DateTime time;
  final bool read;

  const ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.isAstrologer,
    required this.text,
    required this.time,
    this.read = true,
  });
}

class ChatThreadModel {
  final String id;
  final String clientId;
  final String clientName;
  final String clientImage;
  final String lastMessage;
  final DateTime lastTime;
  final int unread;
  final bool starred;
  final bool online;

  const ChatThreadModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.lastMessage,
    required this.lastTime,
    required this.unread,
    this.starred = false,
    this.online = false,
  });
}
