class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  final String type;
  final bool read;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.read = false,
  });

  NotificationModel copyWith({bool? read}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      time: time,
      type: type,
      read: read ?? this.read,
    );
  }
}
