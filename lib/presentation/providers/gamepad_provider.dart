import 'dart:async';
import 'dart:math' as math;
import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:gamepads/gamepads.dart';

class GamepadProvider with ChangeNotifier {
  final AxisSelectorProvider axisSelector;
  final ControlService controlService;
  final AbsPosProvider absPosProvider;
  final MachPosProvider machPosProvider;

  StreamSubscription<GamepadEvent>? _subscription;

  Offset _joystickPosition = Offset.zero;
  double _joystickMagnitude = 0.0;
  String _lastKey = '';
  bool _buttonPressed = false;
  bool _deadman = false;

  ValueNotifier<bool> isYBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isXBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isRBeingDragged = ValueNotifier(false);
  ValueNotifier<bool> isUBeingDragged = ValueNotifier(false);

  GamepadProvider({
    required this.axisSelector,
    required this.controlService,
    required this.absPosProvider,
    required this.machPosProvider,
  });

  Offset get joystickPos => _joystickPosition;
  double get magnitude => _joystickMagnitude;
  String get lastKey => _lastKey;
  bool get buttonPressed => _buttonPressed;
  bool get deadman => _deadman;

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
    if (event.key.contains('Z')) {
      // print("DEADMAN detectado");
      // _updateDeadman(event);
      // return;
    }

    if (!_deadman) {
      // Si el deadman NO está presionado → ignoramos joystick
      return;
    }

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

    if (event.key == 'button-2' || event.key == 'button-3') {
      print("DEADMAN detectado por botón");
      _updateDeadman(event);
      return;
    }

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
          absPosProvider.startStream();
          machPosProvider.startStream();
          print("ENTRAAAA AL CONTROL DEL X");
          print("EJE: ${axisSelector.selectedHAxis}");
          controlService.startJog(axisSelector.selectedHAxis!, direction);
        }
        if (event.key.contains("R")) {
          absPosProvider.startStream();
          machPosProvider.startStream();
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
        absPosProvider.stopStream();
        machPosProvider.stopStream();
        absPosProvider.stopStream();
        machPosProvider.stopStream();
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

  // void _updateDeadmanAnalog(GamepadEvent event) {
  //   // bool newValue = event.value == 128;
  //   bool newValue;
  //   if (event.value != 128 && event.value != 32767 && event.value != 65408) {
  //     newValue = true;
  //   } else {
  //     newValue = false;
  //   }

  //   if (_deadman != newValue) {
  //     _deadman = newValue;
  //     print("Deadman: ${newValue ? "PRESIONADO" : "SUELTO"}");

  //     if (newValue) {
  //       // Deadman presionado
  //       // Puede habilitar Jog
  //       print("Jog habilitado por Deadman");
  //     } else {
  //       // Deadman suelto
  //       // Frenar ejes
  //       print("Jog detenido por Deadman");

  //       controlService.stopJog([
  //         axisSelector.selectedHAxis,
  //         axisSelector.selectedVAxis,
  //       ]);

  //       absPosProvider.stopStream();
  //       machPosProvider.stopStream();
  //       absPosProvider.stopStream();
  //       machPosProvider.stopStream();
  //     }

  //     notifyListeners();
  //   }
  // }

  void _updateDeadman(GamepadEvent event) {
    // Deadman activo si el botón 2 o 3 está presionado (value > 0)
    bool newValue = event.value > 0;

    if (_deadman != newValue) {
      _deadman = newValue;
      print("Deadman: ${newValue ? "PRESIONADO" : "SUELTO"}");

      if (newValue) {
        // Deadman presionado → habilita Jog
        print("Jog habilitado por Deadman");
      } else {
        // Deadman suelto → detener jog y streams
        print("Jog detenido por Deadman");

        controlService.stopJog([
          axisSelector.selectedHAxis,
          axisSelector.selectedVAxis,
        ]);

        absPosProvider.stopStream();
        machPosProvider.stopStream();
      }

      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
