

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) => onKey(event, context),
      child: Row(
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
      ),
    );
  }

  void onLeft(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).move(Direction.LEFT);
  }

  void onRight(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).move(Direction.RIGHT);
  }
  void onUp(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).move(Direction.UP);
  }

  void onDown(BuildContext context) {
    Provider.of<Game2048Model>(context, listen: false).move(Direction.DOWN);
  }

  void onKey(RawKeyEvent event, BuildContext context) {
    if (event is RawKeyDownEvent) {
      if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)
          || event.physicalKey == PhysicalKeyboardKey.keyW) {
        onUp(context);
      } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)
          || event.physicalKey == PhysicalKeyboardKey.keyA) {
        onLeft(context);
      } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)
          || event.physicalKey == PhysicalKeyboardKey.keyD) {
        onRight(context);
      } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)
          || event.physicalKey == PhysicalKeyboardKey.keyS) {
        onDown(context);
      }
    }
    // if (event.character != null)
    //   print(event.character);
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
    // final gameModel = Provider.of<Game2048Model>(context, listen: false);
    print("C");
    // Provider.of<Game2048Model>(context).tileModels.forEach(print);
    // print(Provider.of<Game2048Model>(context).tileModels);
  }

}
