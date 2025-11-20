import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/rapid_trav_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RapidTravSelectorWidget extends StatelessWidget {
  const RapidTravSelectorWidget({super.key, required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, RapidTravSelectorProvider provider, child) =>
          GestureDetector(
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: provider.value == value
                    ? Colors.indigo
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
              width: mediaQuery.width * 0.105,
              height: mediaQuery.height * 0.125,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.01,
                  vertical: mediaQuery.height * 0.01,
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "$value%",
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: provider.value == value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            onTap: () {
              provider.value = value;
            },
          ),
    );
  }
}
