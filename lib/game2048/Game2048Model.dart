
import 'dart:math';

import 'package:flutter/material.dart';

class Game2048Model extends ChangeNotifier{

  /// y, x
  @deprecated
  final List<List<int>> gridValues;
  final int width;
  final int height;

  final List<_TileModel> tileModels;

  Game2048Model(this.gridValues,  this.width, this.height,)
      : tileModels = <_TileModel>[];

  Game2048Model.fromSize({required int width, required int height})
    : this(List.generate(height, (index) => List.filled(width, 0)),
      width, height);

  /// value 2 -> exponent 1
  bool spawn2Old({int? x, int? y}) {
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

  @deprecated
  int _getValueOld(int x, int y) {
    return gridValues[y][x];
  }

  @deprecated
  void _setValueOld({required int x, required int y, required int value}) {
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
    print("s24");
    final emptyFields = coordinates()
      .where((coord) =>
          (!tileModels.any((tile) => tile.pos == coord))
      )
    .toList();
    if (emptyFields.isEmpty) {
      return false;
    } else {
      final random = Random();
      int rndIdx = random.nextInt(emptyFields.length);
      final coordinate = emptyFields[rndIdx];
      tileModels.add(_TileModel(
          exponent: random.nextBool() ? 1 : 2,
          pos: coordinate,
        )
      );
      notifyListeners();
      return true;
    }
  }

  @deprecated
  bool spawn2or4Old() {
    final emptyFields = coordinates()
      .where((xy) => _getValueOld(xy.x, xy.y) == 0)
      .toList(growable: false);
    if (emptyFields.isEmpty) {
      return false; // no more empty space
    } else {
      final random = Random();
      int rndIdx = random.nextInt(emptyFields.length);
      final point = emptyFields[rndIdx];
      _setValueOld(x: point.x, y: point.y, value: random.nextBool() ? 1 : 2);
      notifyListeners();
      return true;
    }
  }

  /// set all values to 0
  @deprecated
  void resetOld() {
    gridValues.forEach((sub) {sub.fillRange(0, sub.length, 0);});
    notifyListeners();
  }

  /// remove all tiles
  void reset() {
    tileModels.clear();
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
class _TileMove {
  final Point from;
  final Point to;
  final int exponent;

  _TileMove({required this.from, required this.to, required this.exponent});

}

class _TileModel {
  final int exponent;
  Point<int> pos;

  int get xPos => pos.x;
  int get yPos => pos.y;
  set xPos(int newX) => pos = Point(newX, yPos);
  set yPos(int newY) => pos = Point(xPos, newY);

  _TileModel({required this.exponent, required this.pos});
  // _TileModel.fromXY({required this.exponent, required this.xPos, required this.yPos});

}