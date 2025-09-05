import 'package:get/get.dart';

import '../core/const/enums.dart';
import 'game_controller.dart';

class SnakeController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  int _guide = 1;
  late Deriction _deriction;
  late List<int> pixels;
  late int ballLocation;
  final List<Deriction> _footPrint = [];

  @override
  void onInit() {
    _getRandomVars();
    super.onInit();
  }

  void _getRandomVars() {
    List<int> allPixels = List.generate(224, (i) => i);
    allPixels.shuffle();
    // get random snake pixel
    pixels = [allPixels[0]];
    // get random ball pixels
    allPixels.removeAt(0);
    ballLocation = allPixels[0];
    //get random deriction
    List<int> deriLengths = [0, 1, 2, 3];
    deriLengths.shuffle();
    _deriction = Deriction.values[deriLengths[0]];
  }

  void reInit() {
    pixels = [];
    _getRandomVars();
    update(['pixel']);
  }

  void toTop() {
    _deriction = Deriction.top;
  }

  void toBottom() {
    _deriction = Deriction.bottom;
  }

  void toLeft() {
    _deriction = Deriction.left;
  }

  void toRight() {
    _deriction = Deriction.right;
  }

  Future<void> updateLocation() async {
    while (_gContr.isStarting) {
      _loggerPrints();
      for (int i = 0; i < pixels.length; i++) {
        _moveSnake(i == 0 ? _deriction : _footPrint.reversed.toList()[i], i);
      }
      _addHieght(_guide);
      update(['pixel']);
      _loss();
      await Future.delayed(const Duration(milliseconds: 600));
    }
  }

  void _moveSnake(Deriction snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case Deriction.top:
        _guide = -15;
        break;
      case Deriction.bottom:
        _guide = 15;
        break;
      case Deriction.left:
        _guide = -1;
        break;
      case Deriction.right:
        _guide = 1;
    }
    _outSide(_deriction, pixelIndex);
    pixels[pixelIndex] += _guide;
  }

  void _outSide(Deriction snakeDeri, int pixelIndex) {
    switch (snakeDeri) {
      case Deriction.top:
        if (pixels[pixelIndex] < 15) {
          pixels[pixelIndex] += 225;
        }
        break;
      case Deriction.bottom:
        if (pixels[pixelIndex] > 209) {
          pixels[pixelIndex] -= 225;
        }
        break;
      case Deriction.left:
        List<int> leftNums = List.generate(15, (i) => 15 * i);
        if (leftNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] += 15;
        }
        break;
      case Deriction.right:
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

  void _loss() async {
    List<int> pixels = this.pixels
        .skipWhile((item) => item == this.pixels[0])
        .toList();
    if (pixels.contains(this.pixels[0])) {
      _gContr.stop();
      _gContr.status = GameStatus.restart;
      if (_gContr.points > _gContr.topScore) {
        await _gContr.saveTopScore();
      }
    }
  }

  void _changeBallLocation() {
    List<int> allPixels = List.generate(224, (i) => i);
    for (var item in pixels) {
      allPixels.remove(item);
    }
    allPixels.shuffle();
    ballLocation = allPixels[0];
    update(['pixel']);
  }

  void _loggerPrints() {
    _footPrint.add(_deriction);
    if (_footPrint.length > pixels.length) {
      _footPrint.removeAt(0);
    }
  }
}
