import 'package:flutter/material.dart';

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({super.key, required this.program});
  final String program;

  @override
  Widget build(BuildContext context) {
    // Expresión regular para extraer número y descripción
    final regex = RegExp(r'^(O\d+)\((.*)\)$');
    final match = regex.firstMatch(program.trim());

    // Si hace match, separamos; si no, mostramos el string completo como fallback
    final programNumber = match != null ? match.group(1)! : program;
    final description = match != null ? match.group(2)! : '';

    return ListTile(
      title: Text(programNumber),
      subtitle: Text(description),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // Aquí puedes manejar la selección del programa
      },
    );
  }
}
