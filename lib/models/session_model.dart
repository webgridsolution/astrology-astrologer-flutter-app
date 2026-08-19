import 'booking_model.dart';

enum SessionState { upcoming, active, history }

class SessionModel {
  final String id;
  final String bookingId;
  final String clientId;
  final String clientName;
  final String clientImage;
  final ConsultationType type;
  final DateTime dateTime;
  final int durationMinutes;
  final double amount;
  final SessionState state;
  final int? elapsedSeconds;

  const SessionModel({
    required this.id,
    required this.bookingId,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.type,
    required this.dateTime,
    required this.durationMinutes,
    required this.amount,
    required this.state,
    this.elapsedSeconds,
  });

  String get typeLabel => type.label;
}
