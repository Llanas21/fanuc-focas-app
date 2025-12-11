import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Size mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      width: mediaQuery.width * 0.35,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                runSpacing: mediaQuery.height * 0.02,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 24 + MediaQuery.of(context).padding.top,
                      bottom: 24,
                    ),
                    color: Colors.indigo,
                    child: Column(
                      children: [
                        Text(
                          "192.168.50.XX",
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: mediaQuery.height * 0.01),
                        Text(
                          "OPERATION XX",
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: Text('Home', style: textTheme.bodySmall),
                    onTap: () {
                      context.goNamed("/home");
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list),
                    title: Text('Programs', style: textTheme.bodySmall),
                    onTap: () {
                      context.goNamed("/programs");
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.gamepad),
                  //   title: Text('Handle', style: textTheme.bodySmall),
                  //   onTap: () {
                  //     context.goNamed("/handle");
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.settings),
                  //   title: Text('Settings', style: textTheme.bodySmall),
                  //   onTap: () {
                  //     context.goNamed("/settings");
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: Text('Disconnect', style: textTheme.bodySmall),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Cerrar sesión',
                              style: textTheme.bodyMedium,
                            ),
                            content: Text(
                              "¿Estás seguro de que deseas cerrar la sesión?",
                              style: textTheme.bodySmall,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  // AuthService authService = AuthService();
                                  // await authService.signOut();
                                  // context.goNamed('/login');
                                  context.replaceNamed('/conn');
                                },
                                child: Text(
                                  'Aceptar',
                                  style: textTheme.labelSmall,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: Text(
                                  'Cancelar',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
