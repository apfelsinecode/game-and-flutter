
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  static final List<Color> colors = [
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.black
  ];

  final int exponent;
  static final double size = 100;
  static final double borderRadius = 10;

  Tile2048({required this.exponent}) ;
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        width: ((exponent == 0) ? 0 : size),
        height: ((exponent == 0) ? 0 : size),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: exponent == 0 ? Colors.transparent : colors[min(exponent, colors.length - 1)]
        ),
        child: FittedBox(
          child: Text(
            exponent == 0 ? " " : value.toString(),
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 48,
            ),
          ),
          fit: BoxFit.scaleDown,
        )
    );
  }

}

class BackgroundTile2048 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Tile2048.size,
      height: Tile2048.size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Tile2048.borderRadius),
        color: Colors.brown.shade300,
      ),
    );
  }
}
