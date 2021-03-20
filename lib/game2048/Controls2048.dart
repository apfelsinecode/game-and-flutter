

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Game2048Model.dart';

class Controls2048 extends StatelessWidget {

  // final VoidCallback onLeft;
  // final VoidCallback onUp;
  // final VoidCallback onDown;
  // final VoidCallback onRight;


  // Controls2048(this.onLeft, this.onUp, this.onDown, this.onRight);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
        child: Icon(Icons.keyboard_arrow_left),
        onPressed: () => onLeft(context)
        ),
        ElevatedButton(
        child: Icon(Icons.keyboard_arrow_up),
        onPressed: () => onUp(context)
        ),
        ElevatedButton(
        child: Icon(Icons.keyboard_arrow_down),
        onPressed: () => onDown(context)
        ),
        ElevatedButton(
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: () => onRight(context)
        ),
        Container(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () => onA(context),
          child: Text("A"),
          style: ElevatedButton.styleFrom(
            primary: Colors.accents[1],
          ),
        ),
        ElevatedButton(
          onPressed: () => onB(context),
          child: Text("B (reset)"),
          style: ElevatedButton.styleFrom(
            primary: Colors.accents[2],
          ),
        ),
        ElevatedButton(
          onPressed: () => onC(context),
          child: Text("C"),
          style: ElevatedButton.styleFrom(
              primary: Colors.accents[3],
          ),
        ),
      ]
    );
  }

  void onLeft(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).moveLeft();
  }

  void onRight(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).moveRight();
  }
  void onUp(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).moveUp();
  }

  void onDown(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).moveDown();
  }

  void onA(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).spawn2or4();
    // _gameModel.spawn2();
  }
  void onB(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).reset();
    //_gameModel.reset();
  }
  void onC(BuildContext context) {
    final gameModel = Provider.of<Game2048Model>(context, listen: false);
    gameModel.testAnimation();
    // Provider.of<Game2048Model>(context).tileModels.forEach(print);
    // print(Provider.of<Game2048Model>(context).tileModels);
  }

}
