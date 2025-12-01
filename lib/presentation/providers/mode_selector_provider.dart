import 'dart:async';

import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class StatusInfoProvider with ChangeNotifier {
  final ControlService _controlService = ControlService();
  Timer? _timer;

  int? _mode;
  int? get mode => _mode;

  int? _emergency;
  int? get emergency => _emergency;

  int? _alarm;
  int? get alarm => _alarm;

  int? _run;
  int? get run => _run;

  int? _tmmode;
  int? get tmmode => _tmmode;

  StatusInfoProvider() {
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      await _refreshData();
    });
  }

  Future<void> _refreshData() async {
    try {
      _mode = await _controlService.getMode();
      _emergency = await _controlService.getEmergency();
      _alarm = await _controlService.getAlarm();
      _run = await _controlService.getRun();
      _tmmode = await _controlService.getTMmode();

      notifyListeners();
    } catch (e) {
      debugPrint("Error refreshing status info: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // StatusInfoProvider() {
  //   // inicialización directa, sin método
  //   _controlService
  //       .getMode()
  //       .then((value) {
  //         _mode = value;
  //         notifyListeners();
  //       })
  //       .catchError((e) {
  //         debugPrint("Error loading mode: $e");
  //       });

  //   _controlService
  //       .getEmergency()
  //       .then((value) {
  //         _emergency = value;
  //         notifyListeners();
  //       })
  //       .catchError((e) {
  //         debugPrint("Error loading emergency: $e");
  //       });

  //   _controlService
  //       .getAlarm()
  //       .then((value) {
  //         _alarm = value;
  //         notifyListeners();
  //       })
  //       .catchError((e) {
  //         debugPrint("Error loading alarm: $e");
  //       });

  //   _controlService
  //       .getRun()
  //       .then((value) {
  //         _run = value;
  //         notifyListeners();
  //       })
  //       .catchError((e) {
  //         debugPrint("Error loading run: $e");
  //       });

  //   _controlService
  //       .getTMmode()
  //       .then((value) {
  //         _tmmode = value;
  //         notifyListeners();
  //       })
  //       .catchError((e) {
  //         debugPrint("Error loading tmmode: $e");
  //       });
  // }

  set mode(int? mode) {
    _mode = mode;
    _controlService.setMode(mode!);
    notifyListeners();
  }

  // void refresh() {
  //   notifyListeners();
  // }
}
