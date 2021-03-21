
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

  /// grid:
  ///
  /// 1234
  /// 5678
  /// 9abc
  /// defg
  /// result: [[159d],[26ae],[37bf][48cg]]
  ///
  Iterable<List<_TileModel>> columnsFromTop() sync* {
      for (int x = 0; x < width; x++) {
        List<_TileModel> column = <_TileModel>[];
        for (int y = 0; y < height; y++) {
          try {
            column.add(tileModels
                .where((tile) => tile.xPos == x && tile.yPos == y)
                .first);
          } on StateError {
            // next coordinate
          }
        }
        yield column;
      }
  }

  Iterable<List<_TileModel>> columnsFromBottom() {
    return columnsFromTop().map((e) => e.reversed.toList(growable: false));
  }

  /// rows from top to bottom
  Iterable<List<_TileModel>> rowsFromLeft() sync* {
    for (int y = 0; y < height; y++){
      List<_TileModel> row = <_TileModel>[];
      for (int x = 0; x < width; x++) {
        try {
          row.add(tileModels
          .where((element) => element.xPos == x && element.yPos == y)
          .first);
        } on StateError {
          // next coordinate
        }
      }
      yield row;
    }
  }

  /// rows from top to bottom
  Iterable<List<_TileModel>> rowsFromRight() {
    return rowsFromLeft().map((e) => e.reversed.toList(growable: false));
  }

  /// remove all tiles
  void reset() {
    tileModels.clear();
    notifyListeners();
  }

  void moveUp() {
    print("up");
    for (var column in columnsFromTop()) {
      for (int i = 0; i < column.length; i++) {
        column[i].yPos = i;
      }
    }
    notifyListeners();
  }

  void moveLeft() {
    print("left");
    for (var row in rowsFromLeft()) {
      for (int i = 0; i < row.length; i++) {
        row[i].xPos = i;
      }
    }
    notifyListeners();
  }

  void moveRight() {
    print("right");
    for (var row in rowsFromRight()) {
      int x = width - 1;
      for (int i = 0; i < row.length; i++) {
        row[i].xPos = x--;
      }
    }
    notifyListeners();
  }

  void moveDown() {
    print("down");
    for (var column in columnsFromBottom()) {
      int y = height - 1;
      for (int i = 0; i < column.length; i++) {
        column[i].yPos = y--;
      }
    }
    notifyListeners();
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
  _TileModel.fromXY({required exponent, required xPos, required yPos})
    : this(exponent: exponent, pos: Point(xPos, yPos));

  @override
  String toString() {
    return '_TileModel{exponent: $exponent, pos: $pos}';
  }
}