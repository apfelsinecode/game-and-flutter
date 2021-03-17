import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Tile2048.dart';

import 'Game2048Model.dart';

class Grid2048 extends StatefulWidget {
  final double _tilePadding = 10;
  final Game2048Model game2048model;
  
  Grid2048(this.game2048model);
  
  @override
  _Grid2048State createState()
  => _Grid2048State(game2048model);

}

class _Grid2048State extends State<Grid2048> {

  final Game2048Model model;

  int get width => model.width;
  int get height => model.height;

  _Grid2048State(this.model);



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row in model.gridValues)
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



}
