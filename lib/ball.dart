import 'package:flutter/material.dart';

class BallGame extends StatefulWidget {
  @override
  State createState() {
    return _BallGameState();
  }
}

enum _Direction {
  LEFT,
  RIGHT,
  STOP
}

class _BallGameState extends State<BallGame> {

  int ballPos0 = 4;
  int ballPos1 = 2;
  int ballPos2 = 3;

  var ballDir0 = _Direction.LEFT;
  var ballDir1 = _Direction.RIGHT;
  var ballDir2 = _Direction.RIGHT;

  var reflected0 = false;
  var reflected1 = false;
  var reflected2 = false;

  var handPos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                hand(handPos == 0),
                hand(handPos == 1),
                hand(handPos == 2),
              ],
            ),
            Column(
              children: [
                arc(12,
                    ballPos0),
                arc(10,
                    ballPos1),
                arc(8,
                    ballPos2)
              ],
            ),
            Column(
              children: [
                hand(handPos == 0),
                hand(handPos == 1),
                hand(handPos == 2),
              ],
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(onPressed: leftClick, child: Text("<")),
            Text("Button step()"),
            ElevatedButton(onPressed: rightClick, child: Text(">"))
          ],
        )
      ],
    );
  }

  Widget arc(int size, int ballPos) {
    return Text("size: $size, pos: $ballPos");
  }

  Widget hand(bool active) {
    return Text(active ? '||||' : '|  |');
  }

  void leftClick() {
    if (handPos > 0) {
      setState(() {
        handPos--;
      });
    }
  }

  void rightClick() {
    if (handPos < 2) {
      setState(() {
        handPos++;
      });
    }
  }

  void step() {
    setState(() {

    });
  }
}

class _Arc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Arc");
  }
}
