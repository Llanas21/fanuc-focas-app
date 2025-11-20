import 'package:flutter/material.dart';

class FeedrateWidget extends StatelessWidget {
  const FeedrateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Feedrate", style: textTheme.bodyMedium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_left_outlined, size: 48),
            ),
            Text("0", style: textTheme.bodyMedium),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_right_outlined, size: 48),
            ),
          ],
        ),
      ],
    );
  }
}
