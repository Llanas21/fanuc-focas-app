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
          builder: (context, StatusInfoProvider provider, child) {
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
        // Text("*****", style: textTheme.bodySmall),
        Consumer(
          builder: (context, StatusInfoProvider provider, child) {
            if (provider.emergency == 0) {
              return Text("***", style: textTheme.bodySmall);
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.01,
                ),
                child: Text(
                  "EMG",
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              );
            }
          },
        ),
        SizedBox(width: mediaQuery.width * 0.04),

        Consumer(
          builder: (context, StatusInfoProvider provider, child) {
            if (provider.alarm == 0) {
              return Text("***", style: textTheme.bodySmall);
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.01,
                ),
                child: Text(
                  "ALM",
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
              );
            }
          },
        ),
        SizedBox(width: mediaQuery.width * 0.04),
        Consumer(
          builder: (context, StatusInfoProvider provider, child) {
            final Map<int, String> names = {
              0: "RESET",
              1: "STOP",
              2: "HOLD",
              3: "START",
              4: "MSTR",
            };
            return Text(
              names[provider.run] ?? "*****",
              style: textTheme.bodySmall,
            );
          },
        ),
        SizedBox(width: mediaQuery.width * 0.04),

        Consumer(
          builder: (context, StatusInfoProvider provider, child) {
            final Map<int, String> names = {0: "T-MODE", 1: "M-MODE"};
            return Text(
              names[provider.tmmode] ?? "*****",
              style: textTheme.bodySmall,
            );
          },
        ),
      ],
    );
  }
}
