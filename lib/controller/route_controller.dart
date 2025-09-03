import 'package:get/get.dart';
import 'package:snakegame/view/screen/game_page.dart';

import '../core/bindings/game_binding.dart';

class RouteController {
  static GetPage gamePage = GetPage(
    name: '/gamePage',
    page: () => GamePage(),
    binding: GameBinding(),
  );
}
