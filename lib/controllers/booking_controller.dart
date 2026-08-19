import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../services/mock_data_service.dart';

class BookingController extends ChangeNotifier {
  final data = MockDataService.instance;
  String tab = 'All';

  List<BookingModel> get filtered {
    switch (tab) {
      case 'Upcoming':
        return data.bookings.where((b) => b.status == BookingStatus.upcoming).toList();
      case 'Completed':
        return data.bookings.where((b) => b.status == BookingStatus.completed).toList();
      case 'Cancelled':
        return data.bookings.where((b) => b.status == BookingStatus.cancelled).toList();
      default:
        return data.bookings;
    }
  }

  void setTab(String value) {
    tab = value;
    notifyListeners();
  }

  void accept(String id) {
    _update(id, BookingStatus.upcoming);
  }

  void reject(String id) {
    _update(id, BookingStatus.cancelled);
  }

  void complete(String id) {
    _update(id, BookingStatus.completed);
  }

  void _update(String id, BookingStatus status) {
    final i = data.bookings.indexWhere((b) => b.id == id);
    if (i >= 0) {
      data.bookings[i] = data.bookings[i].copyWith(status: status);
      notifyListeners();
    }
  }
}
