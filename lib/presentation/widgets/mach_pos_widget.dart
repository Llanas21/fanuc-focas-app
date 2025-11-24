import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MachPosWidget extends StatefulWidget {
  const MachPosWidget({super.key, required this.axis});
  final int axis;

  @override
  State<MachPosWidget> createState() => _MachPosWidgetState();
}

class _MachPosWidgetState extends State<MachPosWidget> {
  String? initValue;

  @override
  void initState() {
    super.initState();
    ControlService().getMachPosition(widget.axis).then((value) {
      setState(() {
        initValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final machPosProvider = context.watch<MachPosProvider>();
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      width: mediaQuery.width * 0.12,
      height: mediaQuery.height * 0.07,
      child: StreamBuilder<String?>(
        stream: machPosProvider.getStream(widget.axis),
        initialData: initValue,
        builder: (context, snapshot) {
          final value = snapshot.data ?? initValue;

          if (value == null) {
            return Center(
              child: FittedBox(
                child: FittedBox(
                  child: Text("000.000", style: textTheme.bodySmall),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "${int.parse(value) / 1000}",
                  style: textTheme.bodySmall,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
