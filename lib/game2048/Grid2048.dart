
import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Tile2048.dart';

import 'Game2048Model.dart';

class Grid2048 extends StatefulWidget {
  static final double _tilePadding = 10;
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

        Container(
          child: SizedBox(
            width: width * (Tile2048.size + Grid2048._tilePadding) + Grid2048._tilePadding,
            height: height * (Tile2048.size + Grid2048._tilePadding) + Grid2048._tilePadding,
          ),
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: BorderRadius.circular(_borderRadius)
          ),
        ),
        for (var t in backgroundTilesPositionedList()) t,
        for (var t in tilesPositionedList()) t,
      ]
    );
  }


  /// a list of positioned tiles
  Iterable<Widget> tilesPositionedList() {
    return model.tileModels.map((tile) =>
      AnimatedPositioned(
        key: ValueKey(tile.id),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        left: _leftOffset(tile.xPos),
        top: _topOffset(tile.yPos),
        child: Tile2048(exponent: tile.exponent, id: tile.id),
      )
    );
  }
  
  double _leftOffset(int x) => x * (Tile2048.size + Grid2048._tilePadding) + Grid2048._tilePadding;
  double _topOffset(int y) => _leftOffset(y);

  Iterable<Widget> backgroundTilesPositionedList() {
    return model
        .coordinates()
        .map((xy) =>
        Positioned(
            left: _leftOffset(xy.x),
            top: _topOffset(xy.y),
            child: BackgroundTile2048(),
    ));
  }



}
