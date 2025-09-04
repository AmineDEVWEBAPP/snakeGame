import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/utils/methodes.dart';
import 'snake_controller.dart';

class GameController extends GetxController {
  bool isStarting = false;
  bool isStarted = false;
  int points = 0;
  int level = 1;
  late int topScore;
  late final SharedPreferences _shP;

  late final SnakeController _sContr;

  @override
  void onInit() async {
    _shP = await SharedPreferences.getInstance();
    level = _shP.getInt('level') ?? 1;
    topScore = _shP.getInt('topScore') ?? 0;
    super.onInit();
  }

  @override
  void onReady() {
    _sContr = Get.find<SnakeController>();
    update(['info']);
    super.onReady();
  }

  void start() {
    if (!isStarting) {
      logger('Start game');
      !isStarted ? isStarted = true : null;
      isStarting = true;
      update(['startButton']);
      _sContr.updateLocation();
    }
  }

  void stop() {
    if (isStarting) {
      logger('Stop game');
      isStarting = false;
    }
    update(['startButton']);
  }

  Future<void> changeLevel(int level) async {
    logger('change level to $level');
    this.level = level;
    update(['info']);
    await _shP.setInt('level', level);
  }

  Future<void> saveTopScore() async {
    logger('save top Score : $points');
    await _shP.setInt('topScore', points);
  }
}
