import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/const/enums.dart';
import '../core/utils/methodes.dart';
import 'snake_controller.dart';

class GameController extends GetxController {
  bool isStarting = false;
  bool isStarted = false;
  GameStatus status = GameStatus.start;
  int points = 0;
  int level = 1;
  late int topScore;
  late final SharedPreferences _shP;

  late final SnakeController _sContr;

  late bool allowSounde;

  @override
  void onInit() async {
    _shP = await SharedPreferences.getInstance();
    level = _shP.getInt('level') ?? 1;
    topScore = _shP.getInt('topScore') ?? 0;
    allowSounde = _shP.getBool('allowSounde') ?? true;
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
      status = GameStatus.pause;
      update(['statusButton']);
      _sContr.updateLocation();
    }
  }

  void stop() {
    if (isStarting) {
      logger('Stop game');
      status = GameStatus.resume;
      isStarting = false;
    }
    update(['statusButton']);
  }

  void restart() {
    status = GameStatus.pause;
    _sContr.reInit();
    points = 0;
    start();
    update(['statusButton', 'info']);
  }

  Future<void> changeLevel(int level) async {
    logger('change level to $level');
    this.level = level;
    _sContr.speed = getSpeed(level);
    update(['info']);
    await _shP.setInt('level', level);
  }

  Future<void> saveTopScore() async {
    logger('save top Score : $points');
    topScore = points;
    await _shP.setInt('topScore', points);
  }

  Future<void> changeSoundePerm(bool auth) async {
    logger('change sound auth to $auth');
    await _shP.setBool('allowSounde', auth);
    allowSounde = auth;
  }
}
