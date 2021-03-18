
import 'dart:math';

import 'package:flutter/material.dart';

class Game2048Model extends ChangeNotifier{

  /// y, x
  final List<List<int>> gridValues;
  final int width;
  final int height;

  Game2048Model(this.gridValues,  this.width, this.height,);

  Game2048Model.fromSize({required int width, required int height})
    : this(List.generate(height, (index) => List.filled(width, 0)),
      width, height);

  /// value 2 -> exponent 1
  bool spawn2({int? x, int? y}) {
    if (x == null) {
      x = Random().nextInt(width);
    }
    if (y == null) {
      y = Random().nextInt(height);
    }

    gridValues[y][x] = 1;
    notifyListeners();

    return true;
  }

  /// set all values to 0
  void reset() {
    gridValues.forEach((sub) {sub.fillRange(0, sub.length, 0);});
    notifyListeners();
  }


  void moveUp() {
    print("up");
  }

  void moveLeft() {
    print("left");
  }

  void moveRight() {
    print("right");
  }

  void moveDown() {
    print("down");
  }


}