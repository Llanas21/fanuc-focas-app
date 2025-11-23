import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/positions_provider.dart';
import 'package:fanuc_focas_app/presentation/widgets/abs_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/app_bar_row_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/axis_selector_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/drawer_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/jog_joystick_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/vaxis_btn_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/mach_pos_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/position_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeachScreen extends StatefulWidget {
  const TeachScreen({super.key});

  @override
  State<TeachScreen> createState() => _TeachScreenState();
}

class _TeachScreenState extends State<TeachScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas para el BottomNavigationBar
  final List<Widget> _screens = [
    const TeachContent(), // tu pantalla actual
    const Center(child: Text('Programs Screen (en construcción)')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        actions: const [AppBarRowWidget()],
      ),
      body: _screens[_selectedIndex],
      drawer: const DrawerWidget(),

      // 🔽 Aquí añadimos el menú inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.precision_manufacturing),
            label: 'Jogging',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Positions'),
        ],
      ),
    );
  }
}

// 🔹 Muevo el contenido original de Teach aquí
class TeachContent extends StatelessWidget {
  const TeachContent({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Padding(
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
                          children: const [
                            AxisSelectorWidget(axis: 1),
                            AxisSelectorWidget(axis: 2),
                            AxisSelectorWidget(axis: 3),
                            AxisSelectorWidget(axis: 4),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
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
                    children: const [
                      Text("Absolute"),
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
                    children: const [
                      Text("Machine"),
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
                    children: const [
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: () {
                    PositionsProvider().addPosition((
                      axis: AxisSelectorProvider().selectedVAxis,
                      pos: ControlService().getMachPosition(
                        AxisSelectorProvider().selectedVAxis!,
                      ),
                    ));
                  },
                  child: const Text("Save position"),
                ),
                const JogJoystickWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PositionsScreen extends StatelessWidget {
  const PositionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, PositionsProvider provider, child) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          itemCount: provider.positions.length,
          itemBuilder: (context, index) {
            // return PositionWidget(position: provider.positions[index]);
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        );
      },
    );
  }
}
