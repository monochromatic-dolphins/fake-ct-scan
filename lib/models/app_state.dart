// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/tomograph.dart';
import 'package:fake_tomograf/view_models/rectangle_view_model.dart';

class AppState extends ChangeNotifier {
  Tomograph? tomograph;

  bool isTomographReady = false;

  void createTomograph(String resolution, String rays) {
    tomograph = Tomograph(int.parse(resolution), int.parse(rays));
    isTomographReady = true;
    notifyListeners();
  }

  void addRectangle(RectangleViewModel viewModel) {
    tomograph?.rectangles.add(Rectangle.fromViewModel(viewModel));
    notifyListeners();
  }

  void calculate() {
    //TODO: SZYMON TU SE WYWOŁAJ SWOJE
    debugPrint('done');
  }
}
