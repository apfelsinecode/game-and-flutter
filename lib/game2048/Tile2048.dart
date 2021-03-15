
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  final int exponent;
  // static final double size = 0;

  Tile2048({required this.exponent}) ;
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(

        color: Colors.accents[min(exponent, 15)]
      ),
      child: Text(value.toString() + " ")
    );
  }
}
