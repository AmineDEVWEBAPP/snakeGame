import 'package:get/get.dart';

import '../core/utils/methodes.dart';
import 'snake_controller.dart';

class GameController extends GetxController {
  bool isStarting = false;
  bool isStarted = false;
  int points = 0;
  int level = 1;

  late final SnakeController _sContr;

  @override
  void onReady() {
    _sContr = Get.find<SnakeController>();
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
}
