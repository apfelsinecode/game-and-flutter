
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

  int _getValue(int x, int y) {
    return gridValues[y][x];
  }

  void _setValue({required int x, required int y, required int value}) {
    if (0 <= x && x < width && 0 <= y && y < height && value >= 0) {
      gridValues[y][x] = value;
    } else{
      throw ArgumentError();
    }
  }

  /// list (0, 0), (0, 1), ..., (0, width-1), (1, 0), ..., (height-1, width-1)
  Iterable<Point<int>> coordinates() sync* {
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        yield Point(x, y);
      }
    }
  }

  bool spawn2or4() {
    final emptyFields = coordinates()
      .where((xy) => _getValue(xy.x, xy.y) == 0)
      .toList(growable: false);
    if (emptyFields.isEmpty) {
      return false; // no more empty space
    } else {
      final random = Random();
      int rndIdx = random.nextInt(emptyFields.length);
      final point = emptyFields[rndIdx];
      print(point);
      _setValue(x: point.x, y: point.y, value: random.nextBool() ? 1 : 2);
      notifyListeners();
      return true;
    }
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