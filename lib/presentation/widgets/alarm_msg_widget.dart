import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmMsgWidget extends StatelessWidget {
  const AlarmMsgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, StatusInfoProvider modeSelectorProvider, child) =>
          GestureDetector(
            child: Container(
              width: mediaQuery.width * 0.22,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green[200],
                // color: Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.01,
                  vertical: mediaQuery.height * 0.01,
                ),
                child: Column(
                  children: [
                    Text(
                      "",
                      // "Alarm Message",
                      style: textTheme.bodySmall?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {},
          ),
    );
  }
}
