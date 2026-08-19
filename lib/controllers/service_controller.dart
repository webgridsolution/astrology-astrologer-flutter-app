import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/mock_data_service.dart';

class ServiceController extends ChangeNotifier {
  final data = MockDataService.instance;

  List<ServiceModel> get services => data.services;

  void toggle(String id, bool value) {
    final i = data.services.indexWhere((s) => s.id == id);
    if (i >= 0) {
      data.services[i] = data.services[i].copyWith(enabled: value);
      notifyListeners();
    }
  }

  void add(ServiceModel service) {
    data.services.add(service);
    notifyListeners();
  }

  void update(ServiceModel service) {
    final i = data.services.indexWhere((s) => s.id == service.id);
    if (i >= 0) {
      data.services[i] = service;
      notifyListeners();
    }
  }

  ServiceModel? byId(String id) {
    try {
      return data.services.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
