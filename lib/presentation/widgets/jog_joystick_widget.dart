import 'dart:async';
import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:provider/provider.dart';

class JogJoystickWidget extends StatefulWidget {
  const JogJoystickWidget({super.key});

  @override
  State<JogJoystickWidget> createState() => _JogJoystickWidgetState();
}

class _JogJoystickWidgetState extends State<JogJoystickWidget> {
  Timer? _refreshTimer;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    ControlService controlService = ControlService();
    final axisSelectorProvider = Provider.of<AxisSelectorProvider>(
      context,
      listen: false,
    );
    AbsPosProvider absPosProvider = context.watch<AbsPosProvider>();
    MachPosProvider machPosProvider = Provider.of<MachPosProvider>(
      context,
      listen: false,
    );

    int? axis = axisSelectorProvider.selectedVAxis;

    return Joystick(
      includeInitialAnimation: false,
      mode: axis == 1 || axis == 4
          ? JoystickMode.horizontal
          : JoystickMode.vertical,
      stick: CircleAvatar(
        radius: mediaQuery.width * 0.05,
        child: Consumer<AxisSelectorProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return AnimatedContainer(
              decoration: BoxDecoration(
                color: value.selectedVAxis == null
                    ? Colors.grey
                    : Colors.indigo,
                shape: BoxShape.circle,
              ),
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
      base: Container(
        width: mediaQuery.width * 0.5,
        height: mediaQuery.height * 0.5,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
      ),
      listener: (details) {
        if (axisSelectorProvider.selectedVAxis == null) return;

        if (details.y < 0 || details.x < 0) {
          // controlService.stopJog(axisSelectorProvider.selectedAxis!);
          int feedrate = details.x != 0
              ? (details.x.abs() * 100).round()
              : (details.y.abs() * 100).round();

          print(
            "$feedrate es el feedrate del eje ${axisSelectorProvider.selectedVAxis}",
          );
          controlService.startJogFeedrate(
            axisSelectorProvider.selectedVAxis!,
            -1,
            feedrate,
          );
          // controlService.startJog(axisSelectorProvider.selectedAxis!, -1);
          // absPosProvider.startStream(axisSelectorProvider.selectedAxis!);
          // machPosProvider.startStream(axisSelectorProvider.selectedAxis!);
        } else if (details.y > 0 || details.x > 0) {
          // controlService.stopJog(axisSelectorProvider.selectedAxis!);
          int feedrate = details.x != 0
              ? (details.x.abs() * 100).round()
              : (details.y.abs() * 100).round();

          print(
            "$feedrate es el feedrate del eje ${axisSelectorProvider.selectedVAxis}",
          );
          controlService.startJogFeedrate(
            axisSelectorProvider.selectedVAxis!,
            1,
            feedrate,
          );
          // controlService.startJog(axisSelectorProvider.selectedAxis!, 1);
          // absPosProvider.startStream(axisSelectorProvider.selectedAxis!);
          // machPosProvider.startStream(axisSelectorProvider.selectedAxis!);
        } else {
          // controlService.stopJog();
          // absPosProvider.stopStream(axisSelectorProvider.selectedAxis!);
          // machPosProvider.stopStream(axisSelectorProvider.selectedAxis!);
          // absPosProvider.shouldRefresh();
          // machPosProvider.shouldRefresh();
        }
      },
      onStickDragStart: () {
        if (axisSelectorProvider.selectedVAxis == null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Select an axis")));
        } else {
          // absPosProvider.startStream(axisSelectorProvider.selectedVAxis!);
          // machPosProvider.startStream(axisSelectorProvider.selectedVAxis!);
        }
      },
      onStickDragEnd: () {
        // absPosProvider.stopStream(axisSelectorProvider.selectedVAxis!);
        // machPosProvider.stopStream(axisSelectorProvider.selectedVAxis!);
      },
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
