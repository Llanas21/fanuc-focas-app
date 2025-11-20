import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class RapidTravSelectorProvider with ChangeNotifier {
  int? _value;

  int? get value => _value;

  set value(int? value) {
    _value = value;
    notifyListeners();
  }
}
