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
      if (event.type == KeyType.analog) {
        _handleAnalog(event);
      } else if (event.type == KeyType.button) {
        _handleButton(event);
      }
    });
  }

  void _handleAnalog(GamepadEvent event) {
    if (event.key.contains('X')) {
      _joystickPosition = Offset(event.value, _joystickPosition.dy);
      _updateBeingDragged(isXBeingDragged, event.value);
      int direction;
      if ((event.value ~/ 1000) <= 5) {
        direction = -1;
      } else {
        direction = 1;
      }
      isXBeingDragged.value
          ? controlService.startJogFeedrate(
              axisSelector.selectedHAxis!,
              direction,
              100,
            )
          : controlService.stopJog();
    } else if (event.key.contains('Y')) {
      _joystickPosition = Offset(_joystickPosition.dx, event.value);
      _updateBeingDragged(isYBeingDragged, event.value);
    } else if (event.key.contains('R')) {
      _joystickPosition = Offset(_joystickPosition.dx, event.value);
      _updateBeingDragged(isRBeingDragged, event.value);
    } else if (event.key.contains('U')) {
      _joystickPosition = Offset(_joystickPosition.dx, event.value);
      _updateBeingDragged(isUBeingDragged, event.value);
      int direction;
      if ((event.value ~/ 1000) <= 5) {
        direction = -1;
      } else {
        direction = 1;
      }
      isUBeingDragged.value
          ? controlService.startJogFeedrate(
              axisSelector.selectedVAxis!,
              direction,
              100,
            )
          : controlService.stopJog();
    }

    _joystickMagnitude = _joystickPosition.distance;
    notifyListeners();
  }

  void _handleButton(GamepadEvent event) {
    _lastKey = event.key;
    _buttonPressed = event.value > 0;
    notifyListeners();
  }

  void _updateBeingDragged(ValueNotifier<bool> target, double value) {
    bool newValue = (value ~/ 1000) <= 5 || (value ~/ 1000) >= 60;

    if (target.value != newValue) {
      target.value = newValue;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
