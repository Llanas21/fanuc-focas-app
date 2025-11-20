import 'package:fanuc_focas_app/presentation/providers/gamepad_provider.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/app_bar_row_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/axis_selector_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/drawer_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/jog_joystick_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/label_axis_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mach_pos_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PendantScreen extends StatelessWidget {
  const PendantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GamepadProvider>().startListening();

    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.04,
        ),
        actions: [AppBarRowWidget()],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.02,
          vertical: mediaQuery.height * 0.04,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text("Axis", style: textTheme.titleSmall),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AxisSelectorWidget(axis: 1),
                              AxisSelectorWidget(axis: 2),
                              AxisSelectorWidget(axis: 3),
                              AxisSelectorWidget(axis: 4),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AxisSelectorWidget(axis: 5),
                              AxisSelectorWidget(axis: 6),
                              AxisSelectorWidget(axis: 7),
                              AxisSelectorWidget(axis: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Absolute", style: textTheme.titleSmall),
                        AbsPosWidget(axis: 1),
                        AbsPosWidget(axis: 2),
                        AbsPosWidget(axis: 3),
                        AbsPosWidget(axis: 4),
                        AbsPosWidget(axis: 5),
                        AbsPosWidget(axis: 6),
                        AbsPosWidget(axis: 7),
                        AbsPosWidget(axis: 8),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Machine", style: textTheme.titleSmall),
                        MachPosWidget(axis: 1),
                        MachPosWidget(axis: 2),
                        MachPosWidget(axis: 3),
                        MachPosWidget(axis: 4),
                        MachPosWidget(axis: 5),
                        MachPosWidget(axis: 6),
                        MachPosWidget(axis: 7),
                        MachPosWidget(axis: 8),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LabelAxisWidget(label: ""),
                        LabelAxisWidget(label: "1"),
                        LabelAxisWidget(label: "2"),
                        LabelAxisWidget(label: "3"),
                        LabelAxisWidget(label: "4"),
                        LabelAxisWidget(label: "5"),
                        LabelAxisWidget(label: "6"),
                        LabelAxisWidget(label: "7"),
                        LabelAxisWidget(label: "8"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      context.pushNamed("/teach");
                    },
                    label: Text("Teach Mode"),
                    icon: Icon(Icons.arrow_forward),
                  ),
                  JogJoystickWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
