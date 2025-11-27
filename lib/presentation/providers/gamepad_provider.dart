import 'dart:async';
import 'dart:math' as math;
import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';

class GamepadProvider with ChangeNotifier {
  final AxisSelectorProvider axisSelector;
  final ControlService controlService;

  StreamSubscription<GamepadEvent>? _subscription;

  Offset _joystickPosition = Offset.zero;
  double _joystickMagnitude = 0.0;
  String _lastKey = '';
  bool _buttonPressed = false;

  ValueNotifier<bool> isYBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isXBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isRBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isUBeingDragged = ValueNotifier(false);

  GamepadProvider({required this.axisSelector, required this.controlService});

  Offset get joystickPos => _joystickPosition;
  double get magnitude => _joystickMagnitude;
  String get lastKey => _lastKey;
  bool get buttonPressed => _buttonPressed;

  void startListening() {
    print("SE EJECUTA LA FUNCION DE START LISTENING DEL GAMEPAD PROVIDER");
    _subscription = Gamepads.events.listen((event) {
      print("movimiento ${event.value}");
      if (event.type == KeyType.analog) {
        _handleAnalog(event);
      } else if (event.type == KeyType.button) {
        _handleButton(event);
      }
    });
  }

  void _handleAnalog(GamepadEvent event) {
    if (event.key.contains('X')) {
      print("Entra al que contiene la X");
      _joystickPosition = Offset(event.value, _joystickPosition.dy);
      _updateBeingDragged(isXBeingDragged, event);
    }

    if (event.key.contains('R')) {
      print("Entra al que contiene la RRRRRRR");
      _joystickPosition = Offset(_joystickPosition.dx, event.value);
      _updateBeingDragged(isRBeingDragged, event);
    }

    _joystickMagnitude = _joystickPosition.distance;
    notifyListeners();
  }

  void _handleButton(GamepadEvent event) {
    _lastKey = event.key;
    _buttonPressed = event.value > 0;
    notifyListeners();
  }

  void _updateBeingDragged(ValueNotifier<bool> target, GamepadEvent event) {
    bool newValue = (event.value ~/ 1000) <= 5 || (event.value ~/ 1000) >= 60;

    if (target.value != newValue) {
      print("Entra con el eje $event");
      target.value = newValue;
      int direction;
      if ((event.value ~/ 1000) <= 5) {
        direction = -1;
      } else {
        direction = 1;
      }

      if (newValue) {
        if (event.key.contains("X")) {
          print("ENTRAAAA AL CONTROL DEL X");
          print("EJE: ${axisSelector.selectedHAxis}");
          controlService.startJog(axisSelector.selectedHAxis!, direction);
        }
        if (event.key.contains("R")) {
          print("ENTRAAAA AL CONTROL DEL R");
          print("EJE: ${axisSelector.selectedVAxis}");
          controlService.startJog(axisSelector.selectedVAxis!, direction);
        }
      }
      if (!newValue) {
        controlService.stopJog([
          axisSelector.selectedHAxis,
          axisSelector.selectedVAxis,
        ]);
      }

      // newValue
      //     ? controlService.startJogFeedrate(
      //         axisSelector.selectedHAxis!,
      //         direction,
      //         100,
      //       )
      //     : controlService.stopJog();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
