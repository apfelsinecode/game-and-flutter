import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Tile2048.dart';

class Grid2048 extends StatefulWidget {
  final int width;
  final int height;
  final double _tilePadding = 10;
  
  Grid2048({this.width = 4, this.height = 4});
  
  @override
  _Grid2048State createState()
  => _Grid2048State.fromSize(width, height);

}

class _Grid2048State extends State<Grid2048> {

  /// y, x
  final List<List<int>> gridValues;

  // final Game2048Model model;
  final int width;
  final int height;

  _Grid2048State(this.gridValues, this.width,
      this.height);
  // int get width => model.width;
  // int get height => model.height;

  // _Grid2048State(this.model);



  _Grid2048State.fromSize(int width, int height)
      : this(List.generate(height, (index) => List.filled(width, 0)), width,
            height);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row in gridValues)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var value in row)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Tile2048(exponent: value),
                )
            ],
          )
      ],
    );
  }

  /// value 2 -> exponent 1
  bool spawn2({int? x, int? y}) {
    if (x == null) {
      x = Random().nextInt(width);
    }
    if (y == null) {
      y = Random().nextInt(height);
    }
    setState(() {
      gridValues[y!][x!] = 1;
    });
    return false;
  }

}
