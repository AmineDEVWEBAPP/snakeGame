import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '../core/const/consts.dart';
import '../core/const/enums.dart';
import '../core/utils/methodes.dart';
import 'game_controller.dart';

class SnakeController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  List<int> _allPixels = List.generate(224, (i) => i);
  // verticalPixel and horizontalPixel is the next pixel dependant
  // about if is it horizontal or vertical
  final int _verticalPixel = 15;
  final int _horizontalPixel = 1;
  // guid is make pixels move horizontal or vertical
  late int _guide;
  late Direction _deriction;
  // the first item in pixels is head and last item is tail
  late List<int> pixels;
  // height is the pixels withode headPixel
  late int _height;
  late int ball;
  late List<int> _pixelPrint;
  late int speed;
  late int head;
  late int tail;
  bool _allowRedirection = true;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() {
    _getRandomVars();
    speed = getSpeed(_gContr.level);
    super.onInit();
  }

  void _getRandomVars() {
    //get random deriction
    List<int> deriLengths = [0, 1, 2, 3];
    deriLengths.shuffle();
    _deriction = Direction.values[deriLengths[0]];
    // get random snake pixels
    _allPixels.shuffle();
    pixels = [_allPixels.first];
    // get random ball pixels
    ball = _allPixels[1];
    // add first pixel after head pixel
    _increaseHieght(addTail: true);
    _height = pixels.length;
    head = pixels.first;
    tail = pixels.last;
    // init pixelPrint
    _pixelPrint = [head];
  }

  void reInit() {
    pixels = [];
    _getRandomVars();
    update(['pixel']);
  }

  void toTop() {
    if (_deriction != Direction.bottom && _allowRedirection) {
      _deriction = Direction.top;
      _allowRedirection = false;
    }
  }

  void toBottom() {
    if (_deriction != Direction.top && _allowRedirection) {
      _deriction = Direction.bottom;
      _allowRedirection = false;
    }
  }

  void toLeft() {
    if (_deriction != Direction.right && _allowRedirection) {
      _deriction = Direction.left;
      _allowRedirection = false;
    }
  }

  void toRight() {
    if (_deriction != Direction.left && _allowRedirection) {
      _deriction = Direction.right;
      _allowRedirection = false;
    }
  }

  Future<void> updateLocation() async {
    while (_gContr.isStarting) {
      // logger head Pixel for body pixel following the prints
      _loggerPrints();
      // check if the pixel is in outSide appears in opposide side
      _outSide();
      // move the pixel
      _movePixels();
      // when the headPixel == ballPixel add a pixel to snakePixels
      _increaseHieght();
      update(['pixel']);
      _allowRedirection = true;
      // value head and tail pixels
      head = pixels.first;
      tail = pixels.last;
      // when the head == any author pixels working loss methode
      _loss();
      // delayed same time after start next move
      await Future.delayed(Duration(milliseconds: speed));
    }
  }

  void _loggerPrints() {
    _pixelPrint.insert(0, head);
    if (_pixelPrint.length > _height) {
      _pixelPrint.removeLast();
    }
  }

  void _increaseHieght({bool addTail = false}) {
    if (pixels.first == ball || addTail == true) {
      if (addTail == false) {
        if (_gContr.allowSounde) {
          _audioPlayer.play(AssetSource(snakeSoundePath));
        }
      }
      _changeBallLocation();
      _gContr.points++;
      _gContr.update(['info']);
      late int addPixel;
      if (pixels.length > 1) {
        int afterLastPixel =
            pixels[pixels.lastIndexOf(pixels.last) -
                (pixels.length > 1 ? 1 : 0)];
        int lastGuide = afterLastPixel - pixels.last;
        addPixel = pixels.last - lastGuide;
      } else {
        switch (_deriction) {
          case Direction.top:
            _guide = -_verticalPixel;
            break;
          case Direction.bottom:
            _guide = _verticalPixel;
            break;
          case Direction.left:
            _guide = -_horizontalPixel;
            break;
          case Direction.right:
            _guide = _horizontalPixel;
        }
        addPixel = pixels.first - _guide;
      }
      pixels.add(addPixel);
      _height = pixels.length;
    }
  }

  void _movePixels() async {
    // value the guide to move the pixel
    switch (_deriction) {
      case Direction.top:
        _guide = -_verticalPixel;
        break;
      case Direction.bottom:
        _guide = _verticalPixel;
        break;
      case Direction.left:
        _guide = -_horizontalPixel;
        break;
      case Direction.right:
        _guide = _horizontalPixel;
    }
    // move head pixel
    pixels[0] += _guide;
    // move body pixels after head Pixel by for loop for following head pixels Print
    for (int i = 1; i < _height; i++) {
      pixels[i] = _pixelPrint[i - 1];
    }
  }

  void _outSide() {
    // sides nums
    List<int> rightNums = List.generate(15, (i) => (15 * i) + 14);
    List<int> leftNums = List.generate(15, (i) => 15 * i);
    List<int> topNums = List.generate(15, (i) => i);
    List<int> bottomNums = List.generate(15, (i) => i + 210);
    // check each pixel by for loop if is it in outside
    for (int i = 0; i < _height; i++) {
      switch (_deriction) {
        case Direction.top:
          if (topNums.contains(pixels[i])) {
            pixels[i] += 225;
          }
          break;
        case Direction.bottom:
          if (bottomNums.contains(pixels[i])) {
            pixels[i] -= 225;
          }
          break;
        case Direction.left:
          if (leftNums.contains(pixels[i])) {
            pixels[i] += 15;
          }
          break;
        case Direction.right:
          if (rightNums.contains(pixels[i])) {
            pixels[i] -= 15;
          }
      }
    }
  }

  void _loss() async {
    // get pixels widhoud head Pixel
    List<int> pixels = this.pixels
        .skipWhile((item) => item == this.pixels[0])
        .toList();
    if (pixels.contains(this.pixels[0])) {
      if (_gContr.allowSounde) {
        _audioPlayer.play(AssetSource(lossSoundePath));
      }
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
    _allPixels = List.generate(224, (i) => i);
  }
}
