import 'package:fanuc_focas_app/data/services/control_service.dart';
import 'package:fanuc_focas_app/presentation/widgets/app_bar_row_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/drawer_widget.dart';
import 'package:fanuc_focas_app/presentation/widgets/program_widget.dart';
import 'package:flutter/material.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(actions: [AppBarRowWidget()]),
      body: FutureBuilder<List<String>>(
        future: ControlService().getPrograms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Si hay error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Si la respuesta viene vacía o nula
            return const Center(child: Text('No hay programas disponibles.'));
          } else {
            // Todo bien, mostramos la lista
            final programs = snapshot.data!;
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              itemCount: programs.length,
              itemBuilder: (context, index) {
                return ProgramWidget(program: programs[index]);
              },
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "New Program",
          style: textTheme.bodySmall?.copyWith(color: Colors.white),
        ),
      ),
      drawer: DrawerWidget(),
    );
  }
}
