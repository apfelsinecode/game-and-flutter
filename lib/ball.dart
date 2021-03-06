import 'package:flutter/material.dart';

class BallGame extends StatefulWidget {
  @override
  State createState() {
    return _BallGameState();
  }
}

class _BallGameState extends State<BallGame> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                hand(false),
                hand(true),
                hand(false),
              ],
            ),
            Column(
              children: [arc(12, 3), arc(10, 5), arc(8, 2)],
            ),
            Column(
              children: [
                hand(false),
                hand(true),
                hand(false),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Text("Button <"),
            Text("Button step()"),
            Text("Button >")
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
}

class _Arc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Arc");
  }
}
