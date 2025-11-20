import 'dart:async';
import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';

class GamepadProvider with ChangeNotifier {
  final AxisSelectorProvider axisSelector;
  final ControlService controlService;

  StreamSubscription? _sub;
  Timer? _timer;
  Offset _lastPos = Offset.zero;
  String? _lastButton;
  bool _isPaused = false; // ← Para evitar procesar durante la pausa

  GamepadProvider({required this.axisSelector, required this.controlService});

  Offset get pos => _lastPos;

  void startListening() {
    // Escucha eventos del gamepad (solo registra inputs)
    _sub = Gamepads.events.listen((event) {
      if (event.type == KeyType.analog) {
        if (event.key.contains('X')) {
          _lastPos = Offset(event.value, _lastPos.dy);
        } else if (event.key.contains('Y')) {
          _lastPos = Offset(_lastPos.dx, event.value);
        }
      } else if (event.type == KeyType.button) {
        _lastButton = event.key; // ← Guardamos el último botón presionado
      }
    });

    // Procesa continuamente cada 500 ms
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) async {
      if (_isPaused) return; // ← No procesar si estamos en pausa

      // Si se presionó un botón, procesarlo aquí
      if (_lastButton != null) {
        if (_lastButton == "button-4") {
          axisSelector.selectedAxis = axisSelector.selectedAxis! - 1;
          print("Eje cambiado hacia atrás");
        } else if (_lastButton == "button-5") {
          axisSelector.selectedAxis = axisSelector.selectedAxis! + 1;
          print("Eje cambiado hacia adelante");
        }

        _lastButton = null; // Limpiar el botón procesado

        // Pausa de 100 ms
        _isPaused = true;
        await Future.delayed(const Duration(seconds: 1));
        _isPaused = false;
      }

      // --- Lógica de movimiento del joystick ---
      int direction = 0;

      if (_lastPos.dy > 34000) {
        direction = -1;
      } else if (_lastPos.dy < 30000) {
        direction = 1;
      }

      print(axisSelector.selectedAxis);

      if (axisSelector.selectedAxis != null && direction != 0) {
        print("El valor de direction es: $direction");
        controlService.startJogFeedrate(
          axisSelector.selectedAxis!,
          direction,
          100,
        );
      } else {
        controlService.stopJog();
      }

      print(_lastPos);
    });
  }

  void stopListening() {
    _sub?.cancel();
    _timer?.cancel();
  }
}
