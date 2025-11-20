import 'package:flutter/material.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget({super.key, required this.position});
  final String position;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(position));
  }
}
