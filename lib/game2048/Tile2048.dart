
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  final int exponent;
  final double size = 50;
  final double borderRadius = 10;

  Tile2048({required this.exponent}) ;
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return Container(
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
