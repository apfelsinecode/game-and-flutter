
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  final int exponent;
  static final double size = 100;
  static final double borderRadius = 10;


  Tile2048({required this.exponent}) ;
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        backgroundTile(),
        AnimatedContainer(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeOut,
            width: ((exponent == 0) ? 0 : size),
            height: ((exponent == 0) ? 0 : size),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: exponent == 0 ? Colors.transparent : Colors.accents[min(exponent, 15)]
            ),
            child: FittedBox(
              child: Text(exponent == 0 ? " " : value.toString()),
              fit: BoxFit.scaleDown,
            )
        ),
      ],
    );
  }

  Widget backgroundTile() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.brown.shade300,
      ),
    );
  }
}
