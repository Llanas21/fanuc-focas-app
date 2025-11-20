import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeSelectorWidget extends StatelessWidget {
  const ModeSelectorWidget({super.key, required this.mode});
  final int mode;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    final Map<int, String> names = {
      3: "EDIT",
      1: "MEM",
      0: "MDI",
      4: "INC",
      5: "JOG",
      6: "ZRN",
    };

    return Consumer(
      builder: (context, ModeSelectorProvider modeSelectorProvider, child) =>
          GestureDetector(
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: modeSelectorProvider.mode == mode
                    ? Colors.indigo
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: mediaQuery.width * 0.14,
              height: mediaQuery.height * 0.105,
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
                      names[mode]!,
                      style: textTheme.bodySmall?.copyWith(
                        color: modeSelectorProvider.mode == mode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              modeSelectorProvider.mode = mode;
            },
          ),
    );
  }
}
