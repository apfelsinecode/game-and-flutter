
import 'package:flutter/material.dart';
import 'package:game_and_flutter/game2048/Game2048Model.dart';
import 'package:game_and_flutter/game2048/Grid2048.dart';


class Game2048 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {

  //final _gameModel = ;

  final _grid = Grid2048(Game2048Model.fromSize(width: 4, height: 4));


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            _grid,
            FittedBox(
              child: controlButtonRow(),
              fit: BoxFit.contain
            ),
          ],
        ),
    );
  }

  Widget controlButtonRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            child: Icon(Icons.keyboard_arrow_left),
            onPressed: onLeft
        ),
        ElevatedButton(
            child: Icon(Icons.keyboard_arrow_up),
            onPressed: onUp
        ),
        ElevatedButton(
            child: Icon(Icons.keyboard_arrow_down),
            onPressed: onDown
        ),
        ElevatedButton(
            child: Icon(Icons.keyboard_arrow_right),
            onPressed: onRight
        ),
        Container(
          width: 20,
        ),
        ElevatedButton(
          onPressed: onA,
          child: Text("A"),
          style: ElevatedButton.styleFrom(
            primary: Colors.accents[1],
          ),
        ),
        ElevatedButton(
          onPressed: onB,
          child: Text("B"),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            elevation: 0
          ),
        ),
        ElevatedButton(
          onPressed: onC,
          child: Text("C"),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            elevation: 0
          ),
        ),


      ],
    );
  }

  void onA() {

  }
  void onB() {

  }
  void onC() {

  }

  void onLeft() {

  }

  void onRight() {

  }
  void onUp() {

  }

  void onDown() {

  }

}
