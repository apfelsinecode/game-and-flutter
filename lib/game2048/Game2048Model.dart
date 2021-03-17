
import 'dart:math';

class Game2048Model {

  /// y, x
  final List<List<int>> gridValues;
  final int width;
  final int height;

  Game2048Model(this.gridValues,  this.width, this.height,);

  Game2048Model.fromSize({required int width, required int height})
    : this(List.generate(height, (index) => List.filled(width, 0)),
      width, height);

  /// value 2 -> exponent 1
  bool spawn2({int? x, int? y}) {
    if (x == null) {
      x = Random().nextInt(width);
    }
    if (y == null) {
      y = Random().nextInt(height);
    }
    // setState(() {
      gridValues[y][x] = 1;
    // });
    return false;
  }


}