import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class RapidTravSelectorProvider with ChangeNotifier {
  ControlService controlService = ControlService();
  int? _value = 0;

  int? get value => _value;

  set value(int? value) {
    _value = value;
    controlService.setRapidTraverse(value!);
    print("SE SETTEA RAPID TRAVERSE");
    notifyListeners();
  }
}
