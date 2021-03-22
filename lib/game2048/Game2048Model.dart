
import 'dart:math';

import 'package:flutter/material.dart';

enum Direction {
  UP, LEFT, RIGHT, DOWN
}

class Game2048Model extends ChangeNotifier{

  /// y, x
  @deprecated
  final List<List<int>> gridValues;
  final int width;
  final int height;

  final List<_TileModel> tileModels;

  Game2048Model(this.gridValues,  this.width, this.height,)
      : tileModels = <_TileModel>[] {
    spawn2or4();
    spawn2or4();
  }

  Game2048Model.fromSize({required int width, required int height})
    : this(List.generate(height, (index) => List.filled(width, 0)),
      width, height);



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
          exponent: random.nextBool() ? 1 : 1 /*2*/,
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

  void move(Direction direction) {
    bool change;
    switch (direction) {
      case Direction.UP:
        change = _moveUp();
        break;
      case Direction.LEFT:
        change = _moveLeft();
        break;
      case Direction.RIGHT:
        change = _moveRight();
        break;
      case Direction.DOWN:
        change = _moveDown();
        break;
    }
    if (change) {
      spawn2or4();
      // check if game is winnable
    }
  }

  /// return true iff any tile moved -> require new tile
  bool _moveUp() {
    
    bool change = false;
    
    for (var column in columnsFromTop()) {
      change |= moveTileList(
        tiles: column,
        xOrYGetter: (tile) => tile.yPos,
        xOrYSetter: (tile, y) => tile.yPos = y,
      );
    }
    notifyListeners();
    return change;
    
    // bool change = false;
    // for (var column in columnsFromTop()) {
    //   for (int i = 0; i < column.length; i++) {
    //     if (column[i].yPos != i) {
    //       change = true;
    //       column[i].yPos = i;
    //     }
    //   }
    // }
    // notifyListeners();
    // return change;
  }

  bool _moveLeft() {
    bool change = false;
    for (var row in rowsFromLeft()) {
      for (int i = 0; i < row.length; i++) {
        if (row[i].xPos != i) {
          change = true;
          row[i].xPos = i;
        }
      }
    }
    notifyListeners();
    return change;
  }

  bool _moveRight() {
    bool change = false;
    for (var row in rowsFromRight()) {
      int x = width - 1;
      for (int i = 0; i < row.length; i++) {
        if (row[i].xPos != x) {
          change = true;
          row[i].xPos = x;
        }
        x--;
      }
    }
    notifyListeners();
    return change;
  }

  bool _moveDown() {
    bool change = false;
    for (var column in columnsFromBottom()) {
      int y = height - 1;
      for (int i = 0; i < column.length; i++) {
        if (column[i].yPos != y){
          change = true;
          column[i].yPos = y;
        }
        y--;
      }
    }
    notifyListeners();
    return change;
  }

  /// move tiles as forward as possible and merge tiles with same value
  /// return true iff tiles merged
  bool moveTileList({required List<_TileModel> tiles,
    required int Function(_TileModel) xOrYGetter,
    required void Function(_TileModel, int) xOrYSetter}) {
    bool change = false;
    for(int i = 0; i < tiles.length; i++) {

      if (xOrYGetter(tiles[i]) != i) {
        // tile has to be moved to index i
        change = true;
        xOrYSetter(tiles[i], i);
      }

      if (i < tiles.length - 1 && tiles[i].exponent == tiles[i+1].exponent) {
        // tile i+1 has to merge with tile i (whose pos is i)
        tiles[i].exponent++;
        xOrYSetter(tiles[i+1], i);
        deleteTile(tiles[i+1]);
        i++;
      }
    }
    return change;
  }

  /// tile get removed from grid, but gets time for animation to play
  void deleteTile(_TileModel tile) async {
    await Future.delayed(Duration(seconds: 1));
    tileModels.remove(tile);
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
  static int idCount = 0;
  int id;
  int exponent;
  Point<int> pos;

  int get xPos => pos.x;
  int get yPos => pos.y;
  set xPos(int newX) => pos = Point(newX, yPos);
  set yPos(int newY) => pos = Point(xPos, newY);

  _TileModel({required this.exponent, required this.pos}) : id = idCount++;
  _TileModel.fromXY({required exponent, required xPos, required yPos})
    : this(exponent: exponent, pos: Point(xPos, yPos));

  @override
  String toString() {
    return '_TileModel{exponent: $exponent, pos: $pos}';
  }
}