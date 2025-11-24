import 'package:flutter/material.dart';

class AxisSelectorProvider with ChangeNotifier {
  final Map<String, int?> _axes = {"horizontal": null, "vertical": null};

  int? get selectedHAxis => _axes["horizontal"];
  int? get selectedVAxis => _axes["vertical"];

  set selectedHAxis(int? axis) {
    if (axis != null && axis == selectedVAxis) {
      throw Exception("Horizontal and vertical axis cannot be the same");
    }
    _axes["horizontal"] = axis;
    print(_axes);
    notifyListeners();
  }

  set selectedVAxis(int? axis) {
    if (axis != null && axis == selectedHAxis) {
      throw Exception("Horizontal and vertical axis cannot be the same");
    }
    _axes["vertical"] = axis;
    print(_axes);
    notifyListeners();
  }
}
