import 'package:flutter/material.dart';
import '../models/availability_model.dart';
import '../models/client_model.dart';
import '../models/review_model.dart';
import '../services/mock_data_service.dart';

class ProfileController extends ChangeNotifier {
  final data = MockDataService.instance;

  List<AvailabilityModel> get availability => data.availability;
  List<ReviewModel> get reviews => data.reviews;

  void setDayEnabled(int index, bool value) {
    data.availability[index] = data.availability[index].copyWith(enabled: value);
    notifyListeners();
  }

  void setDayTime(int index, {String? start, String? end}) {
    data.availability[index] =
        data.availability[index].copyWith(startTime: start, endTime: end);
    notifyListeners();
  }

  void replyReview(String id, String reply) {
    final i = data.reviews.indexWhere((r) => r.id == id);
    if (i >= 0) {
      data.reviews[i] = data.reviews[i].copyWith(reply: reply);
      notifyListeners();
    }
  }

  void saveNotes(String clientId, String notes) {
    final i = data.clients.indexWhere((c) => c.id == clientId);
    if (i >= 0) {
      data.clients[i] = data.clients[i].copyWith(notes: notes);
      notifyListeners();
    }
  }

  ClientModel? client(String id) => data.clientById(id);
}
