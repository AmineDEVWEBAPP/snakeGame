import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/drawer_controller.dart';
import '../../controller/game_controller.dart';
import '../../core/config/theme.dart';
import '../widget/game-page/controlle_buttons.dart';
import 'drawer.dart';
import '../widget/drawer/icon.dart';
import '../widget/game-page/game_card.dart';
import '../widget/game-page/info.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _appTheme = AppTheme.theme;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  final GameDrawerController _gdContr = Get.find<GameDrawerController>();

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
                  Info(keyw: 'P', value: controller.points.toString()),
                  Info(keyw: 'LEVEL', value: controller.level.toString()),
                ],
              ),
            ),
            GameCard(),
            SizedBox(height: 40),
            ControlleButtons(),
            SizedBox(height: 50),
            GetBuilder<GameController>(
              id: 'startButton',
              builder: (controller) => ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(_appTheme.cardColor),
                ),
                onPressed: () {
                  controller.isStarting
                      ? controller.stop()
                      : controller.start();
                },
                child: Text(
                  !controller.isStarted
                      ? 'Start'
                      : controller.isStarting
                      ? 'Pause'
                      : 'Resume',
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
