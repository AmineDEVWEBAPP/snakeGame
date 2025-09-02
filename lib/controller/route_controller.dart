import 'package:get/get.dart';
import 'package:snakegame/game_page.dart';

class RouteController {
  static GetPage gamePage = GetPage(name: '/gamePage', page: () => GamePage());
}
