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

    final int? axisId = axes[label];

    return Consumer<AxisSelectorProvider>(
      builder: (context, axisSelectorProvider, child) {
        final bool isSelected = axisSelectorProvider.selectedHAxis == axisId;

        return GestureDetector(
          onTap: () {
            try {
              axisSelectorProvider.selectedHAxis = isSelected ? null : axisId;
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

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            curve: Curves.easeInOut,
            width: mediaQuery.width * 0.06,
            height: mediaQuery.height * 0.07,

            decoration: BoxDecoration(
              color: isSelected ? Colors.indigo : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),

            child: Center(
              child: FittedBox(
                child: Text(
                  label,
                  // style: TextStyle(
                  //   color: isSelected ? Colors.white : Colors.black,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  style: textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
