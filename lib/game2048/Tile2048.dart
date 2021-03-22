
import 'dart:math';

import 'package:flutter/material.dart';

class Tile2048 extends StatelessWidget {
  final int id;

  static final List<Color> colors = [
    Colors.grey,
    Color.fromARGB(255, 236, 226, 216), // 2
    Color.fromARGB(255, 236, 223, 199), // 4
    Color.fromARGB(255, 241, 177, 121), // 8
    Color.fromARGB(255, 244, 149, 99), // 16
    Color.fromARGB(255, 245, 123, 94), // 32
    Color.fromARGB(255, 245, 94, 59), // 64
    Color.fromARGB(255, 235, 206, 113), // 128
    Color.fromARGB(255, 235, 202, 97), // 256
    Color.fromARGB(255, 235, 199, 79), // 512
    Color.fromARGB(255, 235, 195, 63), // 1024
    Color.fromARGB(255, 0, 0, 0), // 2048
    Color.fromARGB(255, 0, 0, 0), // 4096
    Color.fromARGB(255, 0, 0, 0), // 8192

  ];

  final int exponent;
  static final double size = 100;
  static final double borderRadius = 10;

  Tile2048({required this.exponent, required this.id});
  
  int get value => 1 << exponent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        key: UniqueKey(),
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
            exponent == 0 ? " " : "$value#$id", // value.toString(),
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: exponent > 2 ? Colors.white: Colors.black,
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
