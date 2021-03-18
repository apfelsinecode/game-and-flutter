
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  final int exponent;
  final double size = 100;
  final double borderRadius = 10;

  Tile2048({required this.exponent}) ;
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.accents[min(exponent, 15)]
      ),
      child: FittedBox(
        child: Text(value.toString() + " "),
        fit: BoxFit.scaleDown,
      )
    );
  }
}
