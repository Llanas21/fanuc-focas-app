import 'package:flutter/material.dart';

class PositionsProvider extends ChangeNotifier {
  final List<Record> _positions = [];

  List<Record> get positions => _positions;

  void addPosition(Record position) {
    _positions.add(position);
  }
}
