import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';

class AbsPosWidget extends StatefulWidget {
  const AbsPosWidget({super.key, required this.axis});
  final int axis;

  @override
  State<AbsPosWidget> createState() => _AbsPosWidgetState();
}

class _AbsPosWidgetState extends State<AbsPosWidget> {
  String? initValue;

  @override
  void initState() {
    super.initState();
    ControlService().getAbsPosition(widget.axis).then((value) {
      setState(() {
        initValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final absPosProvider = context.watch<AbsPosProvider>();
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      width: mediaQuery.width * 0.12,
      height: mediaQuery.height * 0.07,
      child: StreamBuilder<String?>(
        stream: absPosProvider.getStream(widget.axis),
        initialData: initValue,
        builder: (context, snapshot) {
          final value = snapshot.data ?? initValue;

          if (value == null) {
            return Center(
              child: FittedBox(
                child: Text("000.000", style: textTheme.bodySmall),
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
