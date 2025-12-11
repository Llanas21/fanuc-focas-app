import 'dart:async';

import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class MachPosProvider with ChangeNotifier {
  final ControlService _controlService = ControlService();

  StreamController<List<String?>>? _controller;
  Timer? _timer;
  bool _running = false;

  /// Stream único de lista de posiciones
  Stream<List<String?>> get stream {
    _controller ??= StreamController<List<String?>>.broadcast();
    return _controller!.stream;
  }

  /// Inicia un solo stream para todas las posiciones
  void startStream() {
    print("Se manda a llamar startStream");
    if (_running) return;

    _running = true;
    _controller ??= StreamController<List<String?>>.broadcast();

    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      try {
        List<String> positions = await _controlService.getMachPositions();
        print(
          "Estas son las posiciones que se añaden al controller $positions",
        );
        _controller!.add(positions);
      } catch (e) {
        print("entra en el catch");
        _controller!.add(List.filled(8, null));
      }
    });

    // ❌ NO LLAMAR notifyListeners();
  }

  void stopStream() {
    _running = false;
    _timer?.cancel();
    _timer = null;

    // ❌ NO NOTIFICAR
  }

  @override
  void dispose() {
    stopStream();
    _controller?.close();
    super.dispose();
  }
}
