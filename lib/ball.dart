import 'dart:math';

import 'package:flutter/material.dart';

class BallGame extends StatefulWidget {
  @override
  State createState() {
    return _BallGameState();
  }
}

enum _Direction { LEFT, RIGHT, STOP }

class _BallGameState extends State<BallGame> {
  bool running = false;

  final arc0size = 12;
  final arc1size = 10;
  final arc2size = 8;

  int ballPos0 = 2;
  int ballPos1 = 2;
  int ballPos2 = 2;

  _Direction ballDir0 = _Direction.RIGHT;
  _Direction ballDir1 = _Direction.RIGHT;
  _Direction ballDir2 = _Direction.RIGHT;

  var reflected0 = false;
  var reflected1 = false;
  var reflected2 = false;

  var handPos = 0;

  @override
  Widget build(BuildContext context) {
    // initializeGame();
    return Center(
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              screen(),
              gameControlButtons(),
            ],
          )),
    );
  }

  Widget screen() {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            arcs(),
            SizedBox(height: pow(((arc2size - 2) / 2.0 + 0.5), 2) * 3.2),
            Row( // row of hands and ball stencils
              children: [
                Column(
                  children: [
                    hand(handPos == 0),
                    ballStencil(ballPos0 == -1),
                  ],
                ),
                Column(
                  children: [
                    hand(handPos == 1),
                    ballStencil(ballPos1 == -1),
                  ],
                ),
                Column(
                  children: [
                    hand(handPos == 2),
                    ballStencil(ballPos2 == -1),
                  ],
                ),
                SizedBox(width: (30 * (arc2size - 2)).toDouble()),
                Column(
                  children: [
                    hand(handPos == 0),
                    ballStencil(ballPos2 == arc2size),
                  ],
                ),
                Column(
                  children: [
                    hand(handPos == 1),
                    ballStencil(ballPos1 == arc1size),
                  ],
                ),
                Column(
                  children: [
                    hand(handPos == 2),
                    ballStencil(ballPos0 == arc0size),
                  ],
                ),
              ],
            ), // row of hands and ball stencils
          ],

        ),
      ),
    );
  }

  Widget gameControlButtons() {
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          roundButton(Icon(Icons.chevron_left), leftClick),
          ElevatedButton(onPressed: step, child: Text("step()")),
          roundButton(Icon(Icons.chevron_right), rightClick),
          IconButton(
              icon: running ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              onPressed: playPause)
        ],
      ),
    );
  }

  Widget arcs() {
    return Column(
      children: [
        arc(
          arc0size,
          ballPos0,
          // reflected0
        ),
        arc(
          arc1size,
          ballPos1,
          // reflected1
        ),
        arc(
          arc2size,
          ballPos2,
          // reflected2
        )
      ],
    );
  }

  Widget arc(int size, int ballPos, [bool reflected]) {
    var stencils = <Widget>[];
    for (int i = 0; i < size; i++) {
      stencils.add(Transform.translate(
        offset: Offset(
            0,
            pow((i.toDouble() - size.toDouble() / 2.0 + 0.5), 2)) * 3.2,
        child: ballStencil(i == ballPos, reflected),
      ));
    }
    return Row(
      children: stencils,
    );
  }

  Widget hand(bool active) {
    return Container(
      width: 20,
      height: 10,
      color: active ? Colors.black : Colors.grey,
      margin: EdgeInsets.all(5),
    );
  }

  Widget ballStencil(bool active, [bool reflected]) {
    Color color;
    if (active) {
      if (reflected != null) {
        if (reflected) {
          color = Colors.green;
        } else {
          color = Colors.red;
        }
      } else {
        color = Colors.black;
      }
    } else {
      color = Colors.grey;
    }

    return Container(
      // color:
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      margin: EdgeInsets.all(5),
    );

    //   active ?
    // Text("O") :
    // Text("-");
  }

  Widget roundButton(Icon icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: icon,
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //
    //   ),
    //   child: IconButton(
    //     icon: icon,
    //     onPressed: onPressed,
    //     color: Colors.blue,
    //     disabledColor: Colors.red,
    //   ),
    // );
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

  void playPause() {
    setState(() {
      running = !running;
    });
    if (running) {
      if (checkLost()) {
        initializeGame();
      }

      autoStepper();
    } else {}
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
    if (checkLost()) {
      setState(() {
        running = false;
      });
    }
    setState(() {
      reflected0 = handPos == 0;
      reflected1 = handPos == 1;
      reflected2 = handPos == 2;
    });
  }

  void stepBall0() {
    setState(() {
      if (reflected0 && ballPos0 == 0 && ballDir0 == _Direction.LEFT) {
        ballDir0 = _Direction.RIGHT;
      } else if (reflected2 && ballPos0 == arc0size - 1 && ballDir0 == _Direction.RIGHT) {
        ballDir0 = _Direction.LEFT;
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
    });
  }

  void stepBall1() {
    setState(() {
      if (reflected1) {
        if (ballPos1 == 0 && ballDir1 == _Direction.LEFT) {
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
    });
  }

  void stepBall2() {
    setState(() {
        if (reflected2 && ballPos2 == 0 && ballDir2 == _Direction.LEFT) {
          ballDir2 = _Direction.RIGHT;
        } else if (reflected0 && ballPos2 == arc2size - 1 && ballDir2 == _Direction.RIGHT) {
          ballDir2 = _Direction.LEFT;
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
    });
  }

  Future<void> autoStepper() async {
    while (running) {
      step();
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void initializeGame([int seed]) {
    final random = Random(seed);
    setState(() {
      ballPos0 = random.nextInt(arc0size - 4) + 2;
      ballPos1 = random.nextInt(arc1size - 4) + 2;
      ballPos2 = random.nextInt(arc2size - 4) + 2;
      ballDir0 = random.nextBool() ? _Direction.LEFT : _Direction.RIGHT;
      ballDir1 = random.nextBool() ? _Direction.LEFT : _Direction.RIGHT;
      ballDir2 = random.nextBool() ? _Direction.LEFT : _Direction.RIGHT;
      // running = true;
    });
  }

  bool checkLost() {
    return (ballPos0 < 0 ||
        ballPos0 >= arc0size ||
        ballPos1 < 0 ||
        ballPos1 >= arc1size ||
        ballPos2 < 0 ||
        ballPos2 >= arc2size);
  }
}
