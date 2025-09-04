import 'package:get/get.dart';

import 'game_controller.dart';

class GameDrawerController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  double turns = 0;
  void drawerAnimation() {
    _gContr.stop();
    turns == 0 ? turns = 0.3 : turns = 0;
    update(['drawerIcon']);
  }
}
