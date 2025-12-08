import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';

class FeedrateWidget extends StatefulWidget {
  const FeedrateWidget({super.key});

  @override
  State<FeedrateWidget> createState() => _FeedrateWidgetState();
}

class _FeedrateWidgetState extends State<FeedrateWidget> {
  double _feedrate = 50; // valor inicial
  ControlService controlService = ControlService();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Feedrate", style: textTheme.titleSmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 08.0),
          child: Slider(
            overlayColor: WidgetStateProperty.all(Colors.indigo),
            activeColor: Colors.indigo,
            thumbColor: Colors.indigo,
            min: 1,
            max: 100,
            divisions: 99,
            value: _feedrate,
            label: _feedrate.toInt().toString(),
            onChanged: (value) {
              setState(() {
                controlService.setFeedrate(value.toInt());
                _feedrate = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
