import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HAxisBtnWidget extends StatelessWidget {
  const HAxisBtnWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    final Map<String, int> axes = {
      "X": 1,
      "Y": 2,
      "Z": 3,
      "B": 4,
      "U": 5,
      "V": 6,
      "W": 7,
      "C": 8,
    };

    return Consumer(
      builder: (context, AxisSelectorProvider axisSelectorProvider, child) =>
          SizedBox(
            width: mediaQuery.width * 0.12,
            height: mediaQuery.height * 0.07,
            child: TextButton(
              onPressed: () {
                try {
                  axisSelectorProvider.selectedHAxis == axes[label]
                      ? axisSelectorProvider.selectedHAxis = null
                      : axisSelectorProvider.selectedHAxis = axes[label];
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(e.toString()),
                      ),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(6.0),
                backgroundColor:
                    axisSelectorProvider.selectedHAxis == axes[label]
                    ? Colors.indigo.withValues(alpha: 0.2)
                    : Colors.transparent,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(label, style: textTheme.bodySmall),
              ),
            ),
          ),
    );
  }
}
