import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mach_pos_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllMachPosWidget extends StatefulWidget {
  const AllMachPosWidget({super.key});

  @override
  State<AllMachPosWidget> createState() => _AllMachPosWidgetState();
}

class _AllMachPosWidgetState extends State<AllMachPosWidget> {
  @override
  void initState() {
    super.initState();
    // context.read<MachPosProvider>().startStream(); // ← seguro
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Machine", style: textTheme.titleSmall),
        for (int i = 1; i <= 8; i++) MachPosWidget(axis: i),
      ],
    );
  }
}
