
import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Controls2048.dart';
import 'package:game_and_flutter/game2048/Game2048Model.dart';
import 'package:game_and_flutter/game2048/Grid2048.dart';
import 'package:provider/provider.dart';


class Game2048 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {

  // final Game2048Model _gameModel = Game2048Model.fromSize(width: 4, height: 4);

  // late Grid2048 _grid = Grid2048(_gameModel);

  _Game2048State();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Game2048Model.fromSize(width: 4, height: 4),
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              FittedBox(
                child: Consumer<Game2048Model>(
                  builder: (context, gameModel, child) {
                    return Grid2048(gameModel);
                  },
                ),
              ),
              FittedBox(
                child: controlButtonRow(),
                fit: BoxFit.contain
              ),
            ],
          ),
      ),
    );
  }

  Widget controlButtonRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Controls2048(onLeft, onUp, onDown, onRight),
        Controls2048(),

      ],
    );
  }



}
