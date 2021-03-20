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

  static final double _borderRadius = 10;
  final Game2048Model model;

  int get width => model.width;
  int get height => model.height;

  _Grid2048State(this.model);



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        /*Column(
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
        ),*/
        Container(
          child: SizedBox(
            width: 500,
            height: 500,
          ),
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(_borderRadius)
          ),
        ),

        for (var e in tilesPositionedList()) e
      ]
    );
  }

  /// A [Stack] of positiend tiles.
  Widget tilesStack() {
    final tiles = model.tileModels;

    return Stack(
      children: [
        for (var tile in tiles) // {
          /*Animated*/Positioned(
            left: tile.xPos * 20,
            top: tile.yPos * 20,
            // duration: Duration(milliseconds: 500),
            child: Tile2048(exponent: tile.exponent),
          )
        // }
      ],
    );
  }

  Iterable<Widget> tilesPositionedList() {
    return model.tileModels.map((tile) =>
      AnimatedPositioned(
        duration: Duration(milliseconds: 500),
        left: tile.xPos * (Tile2048.size + 10) + 10,
        top: tile.yPos * (Tile2048.size + 10) + 10,
        child: Tile2048(exponent: tile.exponent),
      )
    );
  }



}
