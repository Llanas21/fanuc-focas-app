import 'dart:io';

import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/providers/axis_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mach_pos_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/mode_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/gamepad_provider.dart';
import 'package:fanuc_focas_app/presentation/providers/rapid_trav_selector_provider.dart';
import 'package:fanuc_focas_app/presentation/screens/conn_screen.dart';
import 'package:fanuc_focas_app/presentation/screens/home_screen.dart';
import 'package:fanuc_focas_app/presentation/screens/pendant_screen.dart';
import 'package:fanuc_focas_app/presentation/screens/programs_screen.dart';
import 'package:fanuc_focas_app/presentation/screens/teach_screen.dart';
import 'package:fanuc_focas_app/presentation/theme/theme_constants.dart';
import 'package:fanuc_focas_app/presentation/providers/abs_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
  }

  WindowOptions windowOptions = const WindowOptions(fullScreen: true);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AbsPosProvider>(
          create: (context) => AbsPosProvider(),
        ),
        ChangeNotifierProvider<MachPosProvider>(
          create: (context) => MachPosProvider(),
        ),
        ChangeNotifierProvider<AxisSelectorProvider>(
          create: (context) => AxisSelectorProvider(),
        ),
        ChangeNotifierProvider<ModeSelectorProvider>(
          create: (context) => ModeSelectorProvider(),
        ),
        ChangeNotifierProvider<RapidTravSelectorProvider>(
          create: (context) => RapidTravSelectorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GamepadProvider(
            axisSelector: context.read<AxisSelectorProvider>(),
            controlService: ControlService(),
            absPosProvider: context.watch<AbsPosProvider>(),
            machPosProvider: context.watch<MachPosProvider>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Fanuc Focas App',
        theme: lightTheme,
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/conn",
  routes: <RouteBase>[
    GoRoute(
      name: "/conn",
      path: "/conn",
      builder: (context, state) {
        return const ConnScreen();
      },
    ),
    GoRoute(
      name: "/home",
      path: "/home",
      builder: (context, state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: "/programs",
      path: "/programs",
      builder: (context, state) {
        return const ProgramsScreen();
      },
    ),
    GoRoute(
      name: "/handle",
      path: "/handle",
      builder: (context, state) {
        return const PendantScreen();
      },
    ),
    GoRoute(
      name: "/teach",
      path: "/teach",
      builder: (context, state) {
        return const TeachScreen();
      },
    ),
  ],
);
