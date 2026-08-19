enum BookingStatus { upcoming, completed, cancelled }

enum ConsultationType { chat, audio, video, kundli, tarot, love }

extension ConsultationTypeLabel on ConsultationType {
  String get label {
    switch (this) {
      case ConsultationType.chat:
        return 'Chat Session';
      case ConsultationType.audio:
        return 'Call Session';
      case ConsultationType.video:
        return 'Video Call';
      case ConsultationType.kundli:
        return 'Kundli Analysis';
      case ConsultationType.tarot:
        return 'Tarot Reading';
      case ConsultationType.love:
        return 'Love Compatibility';
    }
  }
}

class BookingModel {
  final String id;
  final String clientId;
  final String clientName;
  final String clientImage;
  final ConsultationType type;
  final DateTime dateTime;
  final int durationMinutes;
  final double amount;
  final BookingStatus status;

  const BookingModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.type,
    required this.dateTime,
    required this.durationMinutes,
    required this.amount,
    required this.status,
  });

  String get typeLabel => type.label;

  String get statusLabel {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  BookingModel copyWith({BookingStatus? status}) {
    return BookingModel(
      id: id,
      clientId: clientId,
      clientName: clientName,
      clientImage: clientImage,
      type: type,
      dateTime: dateTime,
      durationMinutes: durationMinutes,
      amount: amount,
      status: status ?? this.status,
    );
  }
}
