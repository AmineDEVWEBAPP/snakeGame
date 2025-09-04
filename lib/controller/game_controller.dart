import 'package:get/get.dart';

import '../core/const/enums.dart';
import '../core/utils/methodes.dart';

class GameController extends GetxController {
  int _deriction = 1;
  SnakeDeri _snakeDeri = SnakeDeri.left;
  bool isStarting = false;
  bool isStarted = false;
  List<int> snakePixels = [100];
  final List<SnakeDeri> _footPrint = [];
  int ballLocation = 50;
  int points = 0;
  int level = 1;

  void start() {
    if (!isStarting) {
      logger('Start game');
      !isStarted ? isStarted = true : null;
      isStarting = true;
      update(['startButton']);
      _updateDeri();
    }
  }

  void stop() {
    if (isStarting) {
      logger('Stop game');
      isStarting = false;
    }
    update(['startButton']);
  }

  void toTop() {
    _snakeDeri = SnakeDeri.top;
  }

  void toBottom() {
    _snakeDeri = SnakeDeri.bottom;
  }

  void toLeft() {
    _snakeDeri = SnakeDeri.left;
  }

  void toRight() {
    _snakeDeri = SnakeDeri.right;
  }

  Future<void> _updateDeri() async {
    while (isStarting) {
      _loggerPrints();
      for (int i = 0; i < snakePixels.length; i++) {
        _moveSnake(i == 0 ? _snakeDeri : _footPrint.reversed.toList()[i], i);
      }
      _addHieght(_deriction);
      update(['snakeLocation']);
      _loss();
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }

  void _moveSnake(SnakeDeri snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case SnakeDeri.top:
        _deriction = -15;
        break;
      case SnakeDeri.bottom:
        _deriction = 15;
        break;
      case SnakeDeri.left:
        _deriction = -1;
        break;
      case SnakeDeri.right:
        _deriction = 1;
    }
    _outSide(_snakeDeri, pixelIndex);
    snakePixels[pixelIndex] += _deriction;
  }

  void _outSide(SnakeDeri snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case SnakeDeri.top:
        if (snakePixels[pixelIndex] < 15) {
          snakePixels[pixelIndex] += 225;
        }
        break;
      case SnakeDeri.bottom:
        if (snakePixels[pixelIndex] > 209) {
          snakePixels[pixelIndex] -= 225;
        }
        break;
      case SnakeDeri.left:
        List<int> leftNums = List.generate(15, (i) => 15 * i);
        if (leftNums.contains(snakePixels[pixelIndex])) {
          snakePixels[pixelIndex] += 15;
        }
        break;
      case SnakeDeri.right:
        List<int> rightNums = List.generate(15, (i) => (15 * i) + 14);
        if (rightNums.contains(snakePixels[pixelIndex])) {
          snakePixels[pixelIndex] -= 15;
        }
    }
  }

  void _addHieght(int pixel) {
    if (snakePixels[0] == ballLocation) {
      _changeBallLocation();
      points++;
      update(['info']);
      int addNum = snakePixels.last - _deriction;
      snakePixels.add(addNum);
    }
  }

  void _loss() {
    List<int> pixels = snakePixels
        .skipWhile((item) => item == snakePixels[0])
        .toList();
    if (pixels.contains(snakePixels[0])) {
      stop();
    }
  }

  void _changeBallLocation() {
    List<int> allLocations = List.generate(224, (i) => i);
    for (var item in snakePixels) {
      allLocations.remove(item);
    }
    allLocations.shuffle();
    ballLocation = allLocations[0];
    update(['snakeLocation']);
  }

  void _loggerPrints() {
    _footPrint.add(_snakeDeri);
    if (_footPrint.length > snakePixels.length) {
      _footPrint.removeAt(0);
    }
  }
}
