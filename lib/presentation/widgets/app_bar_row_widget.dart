import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarRowWidget extends StatelessWidget {
  const AppBarRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Row(
      children: [
        Consumer(
          builder: (context, ModeSelectorProvider provider, child) {
            final Map<int, String> names = {
              3: "EDIT",
              1: "MEM",
              0: "MDI",
              4: "INC",
              5: "JOG",
            };
            return Text(
              names[provider.mode] ?? "***",
              style: textTheme.bodySmall,
            );
          },
        ),
        SizedBox(width: mediaQuery.width * 0.04),
        Text("****", style: textTheme.bodySmall),
        SizedBox(width: mediaQuery.width * 0.04),
        Text("***", style: textTheme.bodySmall),
        SizedBox(width: mediaQuery.width * 0.04),
        Text("***", style: textTheme.bodySmall),
        SizedBox(width: mediaQuery.width * 0.04),
        Text("***", style: textTheme.bodySmall),
      ],
    );
  }
}
