import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VAxisBtnWidget extends StatelessWidget {
  const VAxisBtnWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
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
        TextTheme textTheme = Theme.of(context).textTheme;
        final bool isSelected = axisSelectorProvider.selectedVAxis == axisId;

        return GestureDetector(
          onTap: () {
            try {
              axisSelectorProvider.selectedVAxis = isSelected ? null : axisId;
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
