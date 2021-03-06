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

  final arc0size = 12;
  final arc1size = 10;
  final arc2size = 8;

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
                ballStencil(ballPos0 == -1),
                ballStencil(ballPos1 == -1),
                ballStencil(ballPos2 == -1),
              ],
            ),
            Column(
              children: [
                hand(handPos == 0),
                hand(handPos == 1),
                hand(handPos == 2),
              ],
            ),
            Column(
              children: [
                arc(arc0size,
                    ballPos0),
                arc(arc1size,
                    ballPos1),
                arc(arc2size,
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
            Column(
              children: [
                ballStencil(ballPos0 == arc0size),
                ballStencil(ballPos1 == arc1size),
                ballStencil(ballPos2 == arc2size),
              ],
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(onPressed: leftClick, child: Text("<")),
            ElevatedButton(onPressed: step, child: Text("step()")),
            ElevatedButton(onPressed: rightClick, child: Text(">"))
          ],
        )
      ],
    );
  }

  Widget arc(int size, int ballPos) {
    var stencils = <Widget>[];
    for (int i = 0; i < size; i++) {
      stencils.add(ballStencil(i == ballPos));
    }
    return Row(
      children: stencils,
    );
  }

  Widget hand(bool active) {
    return Text(active ? '||||' : '|  |');
  }

  Widget ballStencil(bool active) {
    return active ?
    Text("O") :
    Text("-");
  }

  void leftClick() {
    if (handPos > 0) {
      setState(() {
        handPos--;
      });
      setReflectedAtHandPos();
    }
  }

  void rightClick() {
    if (handPos < 2) {
      setState(() {
        handPos++;
      });
      setReflectedAtHandPos();
    }
  }

  void setReflectedAtHandPos() {
    setState(() {
      switch (handPos) {
        case 0:
          reflected0 = true;
          break;
        case 1:
          reflected1 = true;
          break;
        case 2:
          reflected2 = true;
          break;
      }
    });
  }

  void step() {
    setReflectedAtHandPos();
    stepBall0();
    stepBall1();
    stepBall2();

  }

  void stepBall0() {
    setState(() {
      if (reflected0) {
        if (ballPos0 == 0 && ballDir0 == _Direction.LEFT){
          ballDir0 = _Direction.RIGHT;
        } else if (ballPos0 == arc1size - 1 && ballDir0 == _Direction.RIGHT) {
          ballDir0 = _Direction.LEFT;
        }
      }
      switch (ballDir0) {
        case _Direction.LEFT:
          ballPos0--;
          break;
        case _Direction.RIGHT:
          ballPos0++;
          break;
        case _Direction.STOP:
          break;
      }
      reflected0 = false;
    });
  }

  void stepBall1() {
    setState(() {
      if (reflected1) {
        if (ballPos1 == 0 && ballDir1 == _Direction.LEFT){
          ballDir1 = _Direction.RIGHT;
        } else if (ballPos1 == arc1size - 1 && ballDir1 == _Direction.RIGHT) {
          ballDir1 = _Direction.LEFT;
        }
      }
      switch (ballDir1) {
        case _Direction.LEFT:
          ballPos1--;
          break;
        case _Direction.RIGHT:
          ballPos1++;
          break;
        case _Direction.STOP:
          break;
      }
      reflected1 = false;
    });
  }

  void stepBall2() {
    setState(() {
      if (reflected2) {
        if (ballPos2 == 0 && ballDir2 == _Direction.LEFT){
          ballDir2 = _Direction.RIGHT;
        } else if (ballPos2 == arc2size - 1 && ballDir2 == _Direction.RIGHT) {
          ballDir2 = _Direction.LEFT;
        }
      }
      switch (ballDir2) {
        case _Direction.LEFT:
          ballPos2--;
          break;
        case _Direction.RIGHT:
          ballPos2++;
          break;
        case _Direction.STOP:
          break;
      }
      reflected2 = false;
    });
  }


  void initializeGame() {

  }

  bool checkLost() {
    return (ballPos0 < 0 || ballPos0 >= arc0size
        || ballPos1 < 0 || ballPos1 >= arc1size
        || ballPos2 < 0 || ballPos2 >= arc2size);
  }
}

