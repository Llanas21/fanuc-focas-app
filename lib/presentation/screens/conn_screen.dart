import 'package:carousel_slider/carousel_slider.dart';
import 'package:fanuc_focas_app/data/services/conn_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnScreen extends StatefulWidget {
  const ConnScreen({super.key});

  @override
  State<ConnScreen> createState() => _ConnScreenState();
}

class _ConnScreenState extends State<ConnScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _timeoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    final List<String> images = [
      'assets/images/login1.jpg',
      'assets/images/login2.jpg',
      'assets/images/login3.jpg',
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          Expanded(
            child: SizedBox.expand(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enableInfiniteScroll: true,
                ),
                items: images.map((path) {
                  return Image.asset(
                    path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: mediaQuery.width * 0.4,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome!", style: textTheme.titleLarge),
                        SizedBox(height: mediaQuery.height * 0.04),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: _ipController,
                          decoration: InputDecoration(
                            labelStyle: textTheme.labelSmall,
                            labelText: 'ip',
                            contentPadding: EdgeInsets.all(
                              mediaQuery.height * 0.04,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: _portController,

                          decoration: InputDecoration(
                            labelStyle: textTheme.labelSmall,
                            labelText: 'port',
                            contentPadding: EdgeInsets.all(
                              mediaQuery.height * 0.04,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        TextFormField(
                          onTapOutside: (_) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          controller: _timeoutController,

                          decoration: InputDecoration(
                            labelStyle: textTheme.labelSmall,
                            labelText: 'timeout',
                            contentPadding: EdgeInsets.all(
                              mediaQuery.height * 0.04,
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: mediaQuery.height * 0.04),
                        SizedBox(
                          height: mediaQuery.height * 0.12,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                try {
                                  ConnService connService = ConnService();
                                  await connService.connect(
                                    _ipController.text.trim(),
                                    int.parse(_portController.text.trim()),
                                    int.parse(_timeoutController.text.trim()),
                                  );

                                  print("PASAA POR AQUI");
                                  int handle = await connService.getHandle();
                                  print("ESTE ES EL HANDLE $handle");

                                  if (handle != 0) context.goNamed("/home");
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Connection error',
                                          style: textTheme.bodyMedium,
                                        ),
                                        content: Text(
                                          "Unable to connect. Please check the IP address, port, and timeout values, and ensure that the controller is powered on and connected to the network.",
                                          style: textTheme.bodySmall,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              context.pop();
                                            },
                                            child: Text(
                                              'Aceptar',
                                              style: textTheme.labelSmall
                                                  ?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Connect',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
