import 'package:flutter/material.dart';

class AxisSelectorProvider with ChangeNotifier {
  int? _selectedAxis;

  int? get selectedAxis => _selectedAxis;

  set selectedAxis(int? axis) {
    _selectedAxis = axis;
    notifyListeners();
  }
}
