import 'package:flutter/material.dart';

class AxisSelectorProvider with ChangeNotifier {
  final List<int?> _selectedAxes = [null, null];

  int? get selectedVAxis => _selectedAxes[0];

  int? get selectedHAxis => _selectedAxes[1];

  set selectedVAxis(int? axis) {
    _selectedAxes[0] = axis;
    print(_selectedAxes);
    notifyListeners();
  }

  set selectedHAxis(int? axis) {
    _selectedAxes[1] = axis;
    print(_selectedAxes);
    notifyListeners();
  }
}
