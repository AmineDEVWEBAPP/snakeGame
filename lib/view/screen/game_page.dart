import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/drawer_controller.dart';
import '../../controller/game_controller.dart';
import '../../controller/snake_controller.dart';
import '../../controller/theme_controller.dart';
import '../../core/const/enums.dart';
import '../widget/game-page/controlle_buttons.dart';
import 'drawer.dart';
import '../widget/drawer/icon.dart';
import '../widget/game-page/game_card.dart';
import '../widget/game-page/info.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _appTheme = ThemeController.theme;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  final GameDrawerController _gdContr = Get.find<GameDrawerController>();
  final SnakeController _sContr = Get.find<SnakeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: GameDrawer(),
      onDrawerChanged: (isOpened) {
        _gdContr.drawerAnimation();
      },
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.05),
            DrawerIcon(
              onTap: () {
                _scaffoldState.currentState?.openDrawer();
              },
            ),
            SizedBox(height: Get.height * 0.02),
            GetBuilder<GameController>(
              id: 'info',
              builder: (controller) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Info(keyw: 'SCORE', value: controller.points.toString()),
                  Info(keyw: 'LEVEL', value: controller.level.toString()),
                ],
              ),
            ),
            GameCard(),
            SizedBox(height: 40),
            ControlleButtons(
              left: _sContr.toLeft,
              right: _sContr.toRight,
              top: _sContr.toTop,
              bottom: _sContr.toBottom,
            ),
            SizedBox(height: 50),
            GetBuilder<GameController>(
              id: 'statusButton',
              builder: (controller) => ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(_appTheme.cardColor),
                ),
                onPressed: () {
                  switch (controller.status) {
                    case GameStatus.start || GameStatus.resume:
                      controller.start();
                      break;
                    case GameStatus.pause:
                      controller.stop();
                      break;
                    case GameStatus.restart:
                      controller.restart();
                  }
                },
                child: Text(
                  controller.status.name,
                  style: _appTheme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
