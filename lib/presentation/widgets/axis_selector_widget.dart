import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AxisSelectorWidget extends StatelessWidget {
  const AxisSelectorWidget({super.key, required this.axis});
  final int axis;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, AxisSelectorProvider axisSelectorProvider, child) =>
          GestureDetector(
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: axisSelectorProvider.selectedAxis == axis
                    ? Colors.indigo
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
              width: mediaQuery.width * 0.135,
              height: mediaQuery.height * 0.145,
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
                      axis.toString(),
                      style: TextStyle(
                        color: axisSelectorProvider.selectedAxis == axis
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              axisSelectorProvider.selectedAxis == axis
                  ? axisSelectorProvider.selectedAxis = null
                  : axisSelectorProvider.selectedAxis = axis;
            },
          ),
    );
  }
}
