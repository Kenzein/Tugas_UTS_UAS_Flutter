import 'package:flutter/material.dart';
import 'package:money_laundry/models/order_history.dart';
import 'package:money_laundry/services/history_service.dart';

class HistoryProvider extends ChangeNotifier {
  final HistoryService _service = HistoryService();

  List<OrderHistoryModel> histories = [];

  Future<void> loadHistory() async {
    histories = await _service.getAll();

    print("Jumlah history : ${histories.length}");

    notifyListeners();
  }

  Future<void> deleteHistory(String id) async {
    await _service.delete(id);
    await loadHistory();
  }

  Future<void> clearHistory() async {
    await _service.deleteAll();
    await loadHistory();
  }
}
