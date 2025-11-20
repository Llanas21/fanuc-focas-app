import 'package:fanuc_focas_app/data/services/conn_service.dart';
import 'package:flutter/material.dart';

class ConnProvider with ChangeNotifier {
  late Future<String> _handle;
  final ConnService connService = ConnService();

  Future<String> get handle {
    return _handle;
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
