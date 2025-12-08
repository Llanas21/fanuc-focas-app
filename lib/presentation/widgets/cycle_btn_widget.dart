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

  late final Map<IconData, Function(bool)> actions;

  @override
  void initState() {
    super.initState();

    actions = {
      Icons.play_arrow: (pressed) => controlService.startCycle(pressed),
      Icons.stop: (pressed) => controlService.stopCycle(pressed),
      Icons.refresh: (pressed) => controlService.reset(pressed),
      Icons.home: (pressed) => controlService.home(pressed),
    };
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    Color color = {
      Icons.play_arrow: Colors.greenAccent,
      Icons.stop: Colors.redAccent,
      Icons.refresh: Colors.redAccent,
      Icons.home: Colors.greenAccent,
    }[widget.icon]!;

    return GestureDetector(
      onTapDown: (_) {
        actions[widget.icon]?.call(true);
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        actions[widget.icon]?.call(false);
        setState(() => _isPressed = false);
      },
      onTapCancel: () {
        actions[widget.icon]?.call(false);
        setState(() => _isPressed = false);
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(_isPressed ? 0.90 : 1.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          width: mediaQuery.width * 0.05,
          height: mediaQuery.width * 0.04,
          decoration: BoxDecoration(
            color: _isPressed ? color.withOpacity(0.65) : color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(widget.icon, size: 28, color: Colors.white),
        ),
      ),
    );
  }
}
