import 'package:get/get.dart';

import '../../controller/drawer_controller.dart';
import '../../controller/game_controller.dart';

class GameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GameController());
    Get.lazyPut(() => GameDrawerController());
  }
}
