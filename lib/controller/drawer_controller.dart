import 'package:get/get.dart';

import 'game_controller.dart';

class GameDrawerController extends GetxController {
  final GameController _gContr = Get.find<GameController>();
  double iconTurns = 0;
  void drawerAnimation() {
    _gContr.stop();
    iconTurns == 0 ? iconTurns = 0.3 : iconTurns = 0;
    update(['drawerIcon']);
  }
}
