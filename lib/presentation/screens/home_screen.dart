import 'package:fanuc_focas_app/presentation/providers/gamepad_provider.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/act_cycle_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/alarm_msg_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/app_bar_row_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/cycle_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/drawer_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/haxis_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/vaxis_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mach_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/main_program_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mode_selector_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/rapid_trav_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Key _key = UniqueKey();

  Future<void> _onRefresh() async {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<GamepadProvider>().startListening();

    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mediaQuery.height * 0.12,

        actionsPadding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.04,
        ),
        actions: [AppBarRowWidget()],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.indigo,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * 0.02,
            vertical: mediaQuery.height * 0.04,
          ),
          child: Column(
            key: _key,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.swap_horiz,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: mediaQuery.width * 0.01),
                                  Text("Axis", style: textTheme.titleSmall),
                                ],
                              ),
                              HAxisBtnWidget(label: "X"),
                              HAxisBtnWidget(label: "Y"),
                              HAxisBtnWidget(label: "Z"),
                              HAxisBtnWidget(label: "B"),
                              HAxisBtnWidget(label: "U"),
                              HAxisBtnWidget(label: "V"),
                              HAxisBtnWidget(label: "W"),
                              HAxisBtnWidget(label: "C"),
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // SizedBox(width: mediaQuery.width * 0.06),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ],
                      ),
                    ),
                    SizedBox(width: mediaQuery.width * 0.04),
                    Expanded(
                      child: PageView(
                        children: [
                          MainProgramWidget(),
                          Column(
                            children: [
                              Text(
                                "Rapid Traverse Override",
                                style: textTheme.titleSmall?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RapidTravSelectorWidget(value: 0),
                                    RapidTravSelectorWidget(value: 25),
                                    RapidTravSelectorWidget(value: 50),
                                    RapidTravSelectorWidget(value: 100),
                                  ],
                                ),
                              ),
                              SizedBox(height: mediaQuery.height * 0.045),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AlarmMsgWidget(),
                                    ActCycleWidget(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: mediaQuery.width * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.swap_vert, size: 24, color: Colors.red),
                            SizedBox(width: mediaQuery.width * 0.01),
                            Text("Axis", style: textTheme.titleSmall),
                          ],
                        ),
                        VAxisBtnWidget(label: "X"),
                        VAxisBtnWidget(label: "Y"),
                        VAxisBtnWidget(label: "Z"),
                        VAxisBtnWidget(label: "B"),
                        VAxisBtnWidget(label: "U"),
                        VAxisBtnWidget(label: "V"),
                        VAxisBtnWidget(label: "W"),
                        VAxisBtnWidget(label: "C"),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ModeSelectorWidget(mode: 3),
                    ModeSelectorWidget(mode: 1),
                    ModeSelectorWidget(mode: 0),
                    ModeSelectorWidget(mode: 4),
                    ModeSelectorWidget(mode: 5),
                    ModeSelectorWidget(mode: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
