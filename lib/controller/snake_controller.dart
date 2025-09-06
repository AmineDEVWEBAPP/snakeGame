import 'package:get/get.dart';

import '../core/const/enums.dart';
import '../core/utils/methodes.dart';
import 'game_controller.dart';

class SnakeController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  final List<int> _allPixels = List.generate(224, (i) => i);
  // verticalPixel and horizontalPixel is the next pixel dependant
  // about if is it horizontal or vertical
  final int _verticalPixel = 15;
  final int _horizontalPixel = 1;
  // guid is make pixels move horizontal or vertical
  late int _guide;
  late Deriction _deriction;
  // the first item in pixels is head and last item is tail
  late List<int> pixels;
  late int ball;
  late List<Deriction> _footPrint;
  late int speed;
  late int head;
  late int tail;

  @override
  void onInit() {
    _getRandomVars();
    speed = getSpeed(_gContr.level);
    super.onInit();
  }

  void _getRandomVars() {
    _allPixels.shuffle();
    // get random snake pixel
    pixels = [_allPixels.first];
    head = pixels.first;
    tail = pixels.last;
    // get random ball pixels
    ball = _allPixels[1];
    //get random deriction
    List<int> deriLengths = [0, 1, 2, 3];
    deriLengths.shuffle();
    _deriction = Deriction.values[deriLengths[0]];
    _footPrint = [_deriction];
  }

  void reInit() {
    pixels = [];
    _getRandomVars();
    update(['pixel']);
  }

  void toTop() {
    if (_deriction != Deriction.bottom) {
      _deriction = Deriction.top;
    }
  }

  void toBottom() {
    if (_deriction != Deriction.top) {
      _deriction = Deriction.bottom;
    }
  }

  void toLeft() {
    if (_deriction != Deriction.right) {
      _deriction = Deriction.left;
    }
  }

  void toRight() {
    if (_deriction != Deriction.left) {
      _deriction = Deriction.right;
    }
  }

  Future<void> updateLocation() async {
    while (_gContr.isStarting) {
      // logger head deriction for author pixels follow head
      _loggerPrints();
      // move each pixel by for loop
      for (int i = 0; i < pixels.length; i++) {
        // if the pixel is in outSide appears in opposide side
        _outSide(_deriction, i);
        // move the pixel
        _movePixel(i == 0 ? _deriction : _footPrint[i], i);
        update(['pixel']);
      }
      // when the headPixel == ballPixel add a pixel to snakePixels
      _increaseHieght(_guide);
      // value head and tail pixels
      head = pixels.first;
      tail = pixels.last;
      // when the head == any author pixels working loss methode
      _loss();
      // delayed same time after start next move
      await Future.delayed(Duration(milliseconds: speed));
    }
  }

  void _increaseHieght(int pixel) {
    if (pixels.first == ball) {
      _changeBallLocation();
      _gContr.points++;
      _gContr.update(['info']);
      int addNum = pixels.last - _guide;
      pixels.add(addNum);
    }
  }

  void _movePixel(Deriction snakeDeri, int pixelIndex) async {
    // value the guide to move the pixel
    switch (snakeDeri) {
      case Deriction.top:
        _guide = -_verticalPixel;
        break;
      case Deriction.bottom:
        _guide = _verticalPixel;
        break;
      case Deriction.left:
        _guide = -_horizontalPixel;
        break;
      case Deriction.right:
        _guide = _horizontalPixel;
    }
    // move the pixel
    pixels[pixelIndex] += _guide;
  }

  void _outSide(Deriction snakeDeri, int pixelIndex) {
    List<int> rightNums = List.generate(15, (i) => (15 * i) + 14);
    List<int> leftNums = List.generate(15, (i) => 15 * i);
    List<int> topNums = List.generate(15, (i) => i);
    List<int> bottomNums = List.generate(15, (i) => i + 210);

    switch (snakeDeri) {
      case Deriction.top:
        if (topNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] += 225;
        }
        break;
      case Deriction.bottom:
        if (bottomNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] -= 225;
        }
        break;
      case Deriction.left:
        if (leftNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] += 15;
        }
        break;
      case Deriction.right:
        if (rightNums.contains(pixels[pixelIndex])) {
          pixels[pixelIndex] -= 15;
        }
    }
  }

  void _loggerPrints() {
    _footPrint.insert(0, _deriction);
    if (_footPrint.length > pixels.length) {
      _footPrint.removeLast();
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
    for (var item in pixels) {
      _allPixels.remove(item);
    }
    _allPixels.shuffle();
    ball = _allPixels[0];
  }
}
