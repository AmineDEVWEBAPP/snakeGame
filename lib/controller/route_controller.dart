import 'package:get/get.dart';
import 'package:snakegame/view/screen/game_page.dart';

class RouteController {
  static GetPage gamePage = GetPage(name: '/gamePage', page: () => GamePage());
}
