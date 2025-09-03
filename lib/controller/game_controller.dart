import 'package:get/get.dart';

import '../core/const/enums.dart';

class GameController extends GetxController {
  int snakeLocation = 84;
  int _deriction = 1;
  SnakeDeri _snakeDeri = SnakeDeri.left;
  bool _isStarted = false;

  void start() {
    if (!_isStarted) {
      _isStarted = true;
      _snakeDeri = SnakeDeri.right;
      _updateDeri();
    }
  }

  void stop() {
    _isStarted = false;
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
    while (_isStarted) {
      switch (_snakeDeri) {
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
      _outSide();
      snakeLocation += _deriction;
      update(['snakeLocation']);
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }

  void _outSide() {
    switch (_snakeDeri) {
      case SnakeDeri.top:
        if (snakeLocation < 15) {
          snakeLocation += 225;
        }
        break;
      case SnakeDeri.bottom:
        if (snakeLocation > 209) {
          snakeLocation -= 225;
        }
        break;
      case SnakeDeri.left:
        List<int> leftNums = List.generate(15, (i) => 15 * i);
        if (leftNums.contains(snakeLocation)) {
          snakeLocation += 15;
        }
        break;
      case SnakeDeri.right:
        List<int> rightNums = List.generate(15, (i) => (15 * i) + 14);
        if (rightNums.contains(snakeLocation)) {
          snakeLocation -= 15;
        }
    }
  }
}
