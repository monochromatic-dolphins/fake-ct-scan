import 'package:fake_tomograf/models/rectangle.dart';
import 'package:fake_tomograf/models/tomograph.dart';
import 'package:fake_tomograf/view_models/rectangle_view_model.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Tomograph? _tomograph;

  bool isTomographReady = false;
  void createTomograph(String resolution, String rays) {
    _tomograph = Tomograph(int.parse(resolution),int.parse(rays));
    // TODO notify listeners
    isTomographReady = true;
    notifyListeners();
  }

  void addRectangle(RectangleViewModel viewModel) {
    _tomograph?.rectangles.add(Rectangle.fromViewModel(viewModel));
  }

  void calculate() {
    //TODO: SZYMON TU SE WYWOŁAJ SWOJE
    print('done');
  }
}
