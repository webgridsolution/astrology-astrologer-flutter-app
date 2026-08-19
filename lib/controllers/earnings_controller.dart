import 'package:flutter/material.dart';
import '../mock/mock_transactions.dart';
import '../services/mock_data_service.dart';

class EarningsController extends ChangeNotifier {
  final data = MockDataService.instance;
  String filter = 'Month';

  double get total => 12450;
  double get chat => 4250;
  double get audio => 6800;
  double get other => 1400;
  double get available => 8450;
  double get pending => 2100;
  double get paid => 35200;

  List<Map<String, dynamic>> get chart => mockEarningsPoints;

  void setFilter(String value) {
    filter = value;
    notifyListeners();
  }
}
