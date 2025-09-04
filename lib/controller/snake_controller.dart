import 'package:get/get.dart';

import '../core/const/enums.dart';
import 'game_controller.dart';

class SnakeController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  int _guide = 1;
  SnakeDeri _deriction = SnakeDeri.left;
  final List<SnakeDeri> _footPrint = [];
  List<int> pixels = [100];
  int ballLocation = 50;
  void toTop() {
    _deriction = SnakeDeri.top;
  }

  void toBottom() {
    _deriction = SnakeDeri.bottom;
  }

  void toLeft() {
    _deriction = SnakeDeri.left;
  }

  void toRight() {
    _deriction = SnakeDeri.right;
  }

  Future<void> updateLocation() async {
    while (_gContr.isStarting) {
      _loggerPrints();
      for (int i = 0; i < pixels.length; i++) {
        _moveSnake(i == 0 ? _deriction : _footPrint.reversed.toList()[i], i);
      }
      _addHieght(_guide);
      update(['snakeLocation']);
      _loss();
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }

  void _moveSnake(SnakeDeri snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case SnakeDeri.top:
        _guide = -15;
        break;
      case SnakeDeri.bottom:
        _guide = 15;
        break;
      case SnakeDeri.left:
        _guide = -1;
        break;
      case SnakeDeri.right:
        _guide = 1;
    }
    _outSide(_deriction, pixelIndex);
    pixels[pixelIndex] += _guide;
  }

  void _outSide(SnakeDeri snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case SnakeDeri.top:
        if (pixels[pixelIndex] < 15) {
          pixels[pixelIndex] += 225;
        }
        break;
      case SnakeDeri.bottom:
        if (pixels[pixelIndex] > 209) {
          pixels[pixelIndex] -= 225;
        }
        break;
      case SnakeDeri.left:
        List<int> leftNums = List.generate(15, (i) => 15 * i);
        if (leftNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] += 15;
        }
        break;
      case SnakeDeri.right:
        List<int> rightNums = List.generate(15, (i) => (15 * i) + 14);
        if (rightNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] -= 15;
        }
    }
  }

  void _addHieght(int pixel) {
    if (pixels[0] == ballLocation) {
      _changeBallLocation();
      _gContr.points++;
      _gContr.update(['info']);
      int addNum = pixels.last - _guide;
      pixels.add(addNum);
    }
  }

  void _loss() {
    List<int> pixels = this.pixels
        .skipWhile((item) => item == this.pixels[0])
        .toList();
    if (pixels.contains(this.pixels[0])) {
      _gContr.stop();
    }
  }

  void _changeBallLocation() {
    List<int> allLocations = List.generate(224, (i) => i);
    for (var item in pixels) {
      allLocations.remove(item);
    }
    allLocations.shuffle();
    ballLocation = allLocations[0];
    update(['snakeLocation']);
  }

  void _loggerPrints() {
    _footPrint.add(_deriction);
    if (_footPrint.length > pixels.length) {
      _footPrint.removeAt(0);
    }
  }
}
