import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllAbsPosWidget extends StatefulWidget {
  const AllAbsPosWidget({super.key});

  @override
  State<AllAbsPosWidget> createState() => _AllAbsPosWidgetState();
}

class _AllAbsPosWidgetState extends State<AllAbsPosWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AbsPosProvider>().startStream(); // ← seguro
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Absolute", style: textTheme.titleSmall),
        for (int i = 1; i <= 8; i++) AbsPosWidget(axis: i),
      ],
    );
  }
}
