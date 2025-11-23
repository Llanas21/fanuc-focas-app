import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/cycle_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/vaxis_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mach_pos_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProgramWidget extends StatelessWidget {
  const MainProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    ControlService controlService = ControlService();

    return GestureDetector(
      onTap: () => showProgramDialog(context),
      child: Stack(
        children: [
          FutureBuilder(
            future: controlService.getProgram(2),
            builder: (context, asyncSnapshot) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(mediaQuery.width * 0.01),
                  child: Text(
                    asyncSnapshot.data ?? "Loading...",
                    style: GoogleFonts.firaCode(fontSize: 22),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: mediaQuery.height * 0.01,
            right: mediaQuery.width * 0.01,
            child: Text(
              "O 0001023",
              style: GoogleFonts.sourceCodePro(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showProgramDialog(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Text(
                          "G21 G17 G40 G49 G80 G90\nG54\nT1 M06\nS1500 M03\nM05\nM09\nG28 U0 V0 W0\nM30\nT1 M06\nG17 G40 G49\nG54\nT1 M06\nS1500 M03\nM05\nM09\nG28 U0 V0 W0",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                VAxisBtnWidget(label: ""),
                                VAxisBtnWidget(label: "1"),
                                VAxisBtnWidget(label: "2"),
                                VAxisBtnWidget(label: "3"),
                                VAxisBtnWidget(label: "4"),
                                VAxisBtnWidget(label: "5"),
                                VAxisBtnWidget(label: "6"),
                                VAxisBtnWidget(label: "7"),
                                VAxisBtnWidget(label: "8"),
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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CycleBtnWidget(label: "Start", color: Colors.green[50]!),
                    CycleBtnWidget(label: "Stop", color: Colors.red[50]!),
                    CycleBtnWidget(
                      label: "Start Pos",
                      color: Colors.green[50]!,
                    ),
                    CycleBtnWidget(label: "Reset", color: Colors.red[50]!),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
