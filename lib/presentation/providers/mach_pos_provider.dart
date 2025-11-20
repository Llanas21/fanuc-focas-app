import 'dart:async';

import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class MachPosProvider with ChangeNotifier {
  late Future<String> _machPos;

  Future<String> get machPos => _machPos;

  final ControlService _controlService = ControlService();
  final Map<int, StreamController<String?>> _controllers = {};
  final Map<int, Timer?> _timers = {};
  final Map<int, bool> _running = {};

  Stream<String?> getStream(int axis) {
    _controllers.putIfAbsent(axis, () => StreamController<String?>.broadcast());
    return _controllers[axis]!.stream;
  }

  /// Iniciar stream de un eje
  void startStream(int axis) {
    if (_running[axis] == true) return;

    _running[axis] = true;
    _controllers.putIfAbsent(axis, () => StreamController<String?>.broadcast());

    _timers[axis] = Timer.periodic(const Duration(milliseconds: 100), (
      _,
    ) async {
      try {
        final pos = await _controlService.getMachPosition(axis);
        print("Stream del axis $axis");
        _controllers[axis]!.add(pos);
      } catch (e) {
        _controllers[axis]!.add(null);
      }
    });
    notifyListeners();
  }

  /// Detener stream de un eje
  void stopStream(int axis) {
    _running[axis] = false;
    _timers[axis]?.cancel();
    _timers[axis] = null;
    notifyListeners();
  }

  /// Saber si un eje está corriendo
  bool isRunning(int axis) => _running[axis] ?? false;

  /// Liberar recursos
  void disposeAxis(int axis) {
    stopStream(axis);
    _controllers[axis]?.close();
    _controllers.remove(axis);
    _timers.remove(axis);
    _running.remove(axis);
  }

  @override
  void dispose() {
    for (var axis in _controllers.keys) {
      disposeAxis(axis);
    }
    super.dispose();
  }

  void shouldRefresh() {
    notifyListeners();
  }
}
