import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class ModeSelectorProvider with ChangeNotifier {
  final ControlService _controlService = ControlService();

  int? _mode;
  int? get mode => _mode;

  ModeSelectorProvider() {
    // inicialización directa, sin método
    _controlService
        .getMode()
        .then((value) {
          _mode = value;
          notifyListeners();
        })
        .catchError((e) {
          debugPrint("Error loading mode: $e");
        });
  }

  set mode(int? mode) {
    _mode = mode;
    _controlService.setMode(mode!);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
