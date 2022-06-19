// Flutter imports:
import 'dart:math';

import 'package:fake_tomograf/models/straight_line.dart';
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

  List<double> calculationsGoBrrr(int resolution) {
    var beamsWithLoss = _calculateBeamsWithLoss();
    var beamsWithPixels = _calculateBeamsWithPixels(resolution);
    // print(beamsWithPixels);
    return _calculateThirdTask(beamsWithPixels, beamsWithLoss, 150, resolution);
  }

  Map<StraightLine, double> _calculateBeamsWithLoss() {
    var beamsWithLoss = tomograph?.getBeamsLoss();
    if (beamsWithLoss == null) {
      throw Exception("beamsWithLoss is null");
    }
    return beamsWithLoss;
  }

  Map<StraightLine, List<double>> _calculateBeamsWithPixels(
    int resolution,
  ) {
    var beamsWithPixels = tomograph?.getBeamsWithPixels(resolution);
    if (beamsWithPixels == null) {
      throw Exception("beamsWithPixels is null!");
    }
    return beamsWithPixels;
  }

  List<double> _calculateThirdTask(
      Map<StraightLine, List<double>> beamsWithPixels,
      Map<StraightLine, double> beamsWithLoss,
      int iterations,
      int resolution,
      {double lambda = 1}) {
    var previous = List.filled(resolution * resolution, 0.0);
    var current = <double>[];
    for (var i = 0; i < iterations; i++) {
      for (var beam in beamsWithLoss.keys) {
        var pi = beamsWithLoss[beam];
        var pixelMatrixForBeam = beamsWithPixels[beam];
        if (pixelMatrixForBeam == null) {
          throw Exception("pixelMatrixForBeam is null");
        }
        var scalar = _scalar(previous, pixelMatrixForBeam);
        var denominator = _vectorLength(pixelMatrixForBeam) *
            _vectorLength(pixelMatrixForBeam);
        if (pi == null) {
          throw Exception("pi is null");
        }
        var fractionValue = (pi - scalar) / denominator;
        var factionMultipliedBypixelMatrixForBeam =
            vectorMultipliedByValue(pixelMatrixForBeam, fractionValue);
        var resultMultipliedByLambda = vectorMultipliedByValue(
            factionMultipliedBypixelMatrixForBeam, lambda);
        current = _addVectors(previous, resultMultipliedByLambda);
        previous = current;
      }
    }
    return current.map((e) => e < 0 ? 0.0 : e).toList();
  }

  double _scalar(List<double> vectorA, List<double> vectorB) {
    if (vectorA.length != vectorB.length) {
      throw Exception("vectorA length is different than vectorB length");
    }
    var scalarValue = 0.0;
    for (var i = 0; i < vectorA.length; i++) {
      scalarValue += vectorA[i] * vectorB[i];
    }
    return scalarValue;
  }

  double _vectorLength(List<double> vector) {
    var length = 0.0;
    for (var element in vector) {
      length += element * element;
    }
    return sqrt(length);
  }

  List<double> vectorMultipliedByValue(List<double> vector, double value) {
    return vector.map((e) => e * value).toList();
  }

  List<double> _addVectors(List<double> vectorA, List<double> vectorB) {
    if (vectorA.length != vectorB.length) {
      throw Exception("vectorA length is different than vectorB length");
    }
    var newVector = <double>[];
    for (var i = 0; i < vectorA.length; i++) {
      newVector.add(vectorA[i] + vectorB[i]);
    }
    return newVector;
  }
}
