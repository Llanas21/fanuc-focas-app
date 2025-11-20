import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class CycleBtnWidget extends StatelessWidget {
  const CycleBtnWidget({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ModeSelectorProvider modeSelectorProvider, child) =>
          GestureDetector(
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              width: mediaQuery.width * 0.105,
              height: mediaQuery.height * 0.115,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.04,
                  vertical: mediaQuery.height * 0.02,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      label,
                      style: textTheme.bodySmall?.copyWith(
                        color: modeSelectorProvider.mode == label
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              // modeSelectorProvider.mode = label;
            },
          ),
    );
  }
}
