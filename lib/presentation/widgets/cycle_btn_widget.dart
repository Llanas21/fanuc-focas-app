import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CycleBtnWidget extends StatefulWidget {
  const CycleBtnWidget({super.key, required this.icon});

  final IconData icon;

  @override
  State<CycleBtnWidget> createState() => _CycleBtnWidgetState();
}

class _CycleBtnWidgetState extends State<CycleBtnWidget> {
  bool _isPressed = false;
  final ControlService controlService = ControlService();

  @override
  Widget build(BuildContext context) {
    Color color = {
      Icons.play_arrow: Colors.green,

      Icons.stop: Colors.red,
      Icons.refresh: Colors.red,
      Icons.home: Colors.yellow,
    }[widget.icon]!;
    Size mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTapDown: (_) {
        controlService.startCycle(true);
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        controlService.startCycle(false);
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        controlService.startCycle(false);
        setState(() => _isPressed = false);
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(_isPressed ? 0.90 : 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          width: mediaQuery.width * 0.05,
          height: mediaQuery.width * 0.05,
          decoration: BoxDecoration(
            color: _isPressed ? color.withOpacity(0.65) : color,
            shape: BoxShape.circle,
          ),
          child: Icon(widget.icon, size: 28, color: Colors.white),
        ),
      ),
    );
  }
}
