import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';

class AbsPosWidget extends StatelessWidget {
  final int axis;
  const AbsPosWidget({super.key, required this.axis});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AbsPosProvider>();
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context).size;

    return StreamBuilder<List<String?>>(
      stream: provider.stream,
      builder: (context, snapshot) {
        final list = snapshot.data;

        if (list == null) {
          return FittedBox(child: Text("000.000", style: textTheme.bodySmall));
        }

        final raw = list[axis - 1] ?? "0";
        print("ESTE ES EL RAW");
        print(raw);
        return SizedBox(
          width: mediaQuery.width * 0.12,
          height: mediaQuery.height * 0.07,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                "${int.parse(raw) / 1000}",
                style: textTheme.bodySmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
