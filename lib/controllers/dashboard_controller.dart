import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/mock_data_service.dart';

class DashboardController extends ChangeNotifier {
  final data = MockDataService.instance;
  String earningsFilter = 'This Month';

  List<BookingModel> get todaySchedule => data.bookings
      .where((b) => b.status == BookingStatus.upcoming)
      .take(3)
      .toList();

  List<BookingModel> get recentBookings =>
      data.bookings.where((b) => b.status == BookingStatus.upcoming).take(2).toList();

  int get totalBookings => data.bookings.length;
  int get upcomingSessions =>
      data.bookings.where((b) => b.status == BookingStatus.upcoming).length;
  int get completed =>
      data.bookings.where((b) => b.status == BookingStatus.completed).length;
  int get cancelled =>
      data.bookings.where((b) => b.status == BookingStatus.cancelled).length;
  double get totalEarnings => 12450;
  int get totalClients => data.clients.length + 151;

  void setFilter(String value) {
    earningsFilter = value;
    notifyListeners();
  }
}
