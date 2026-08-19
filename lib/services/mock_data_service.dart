import '../mock/mock_bookings.dart';
import '../mock/mock_chats.dart';
import '../mock/mock_clients.dart';
import '../mock/mock_notifications.dart';
import '../mock/mock_reviews.dart';
import '../mock/mock_services.dart';
import '../mock/mock_transactions.dart';
import '../models/availability_model.dart';
import '../models/booking_model.dart';
import '../models/chat_message_model.dart';
import '../models/client_model.dart';
import '../models/notification_model.dart';
import '../models/payout_model.dart';
import '../models/review_model.dart';
import '../models/service_model.dart';
import '../models/session_model.dart';
import '../models/transaction_model.dart';
import '../utils/constants.dart';

/// In-memory store. Swap this class for API repositories later.
class MockDataService {
  MockDataService._();
  static final MockDataService instance = MockDataService._();

  final List<BookingModel> bookings = List.of(mockBookings);
  final List<ClientModel> clients = List.of(mockClients);
  final List<ServiceModel> services = List.of(mockServices);
  final List<ReviewModel> reviews = List.of(mockReviews);
  final List<NotificationModel> notifications = List.of(mockNotifications);
  final List<TransactionModel> transactions = List.of(mockTransactions);
  final List<PayoutModel> payouts = List.of(mockPayouts);
  final List<ChatThreadModel> threads = List.of(mockThreads);
  final Map<String, List<ChatMessageModel>> messages = {
    for (final e in mockMessages.entries) e.key: List.of(e.value),
  };

  List<AvailabilityModel> availability = [
    const AvailabilityModel(day: 'Monday', enabled: true, startTime: '10:00 AM', endTime: '8:00 PM'),
    const AvailabilityModel(day: 'Tuesday', enabled: true, startTime: '10:00 AM', endTime: '8:00 PM'),
    const AvailabilityModel(day: 'Wednesday', enabled: false, startTime: '10:00 AM', endTime: '8:00 PM'),
    const AvailabilityModel(day: 'Thursday', enabled: true, startTime: '10:00 AM', endTime: '8:00 PM'),
    const AvailabilityModel(day: 'Friday', enabled: true, startTime: '10:00 AM', endTime: '8:00 PM'),
    const AvailabilityModel(day: 'Saturday', enabled: true, startTime: '11:00 AM', endTime: '6:00 PM'),
    const AvailabilityModel(day: 'Sunday', enabled: false, startTime: '10:00 AM', endTime: '4:00 PM'),
  ];

  List<SessionModel> get sessions {
    return bookings.map((b) {
      SessionState state;
      if (b.status == BookingStatus.completed) {
        state = SessionState.history;
      } else if (b.status == BookingStatus.cancelled) {
        state = SessionState.history;
      } else {
        state = SessionState.upcoming;
      }
      return SessionModel(
        id: 'sess-${b.id}',
        bookingId: b.id,
        clientId: b.clientId,
        clientName: b.clientName,
        clientImage: b.clientImage,
        type: b.type,
        dateTime: b.dateTime,
        durationMinutes: b.durationMinutes,
        amount: b.amount,
        state: state,
      );
    }).toList();
  }

  ClientModel? clientById(String id) {
    try {
      return clients.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  BookingModel? bookingById(String id) {
    try {
      return bookings.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  ChatThreadModel threadForClient(String clientId) {
    return threads.firstWhere(
      (t) => t.clientId == clientId,
      orElse: () => ChatThreadModel(
        id: 'ch-$clientId',
        clientId: clientId,
        clientName: clientById(clientId)?.name ?? 'Client',
        clientImage: clientById(clientId)?.image ?? AppAssets.aman,
        lastMessage: '',
        lastTime: DateTime.now(),
        unread: 0,
      ),
    );
  }
}
