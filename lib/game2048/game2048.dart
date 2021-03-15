import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Tile2048.dart';


class Game2048 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int exponent = 1; exponent < 25; exponent++)
              Tile2048(exponent: exponent)
          ],
        )
    );
  }
}
