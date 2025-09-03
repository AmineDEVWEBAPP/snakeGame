import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../../core/config/theme.dart';
import '../widget/game-page/controlle_buttons.dart';
import '../widget/game-page/game_card.dart';
import '../widget/game-page/info.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _appTheme = AppTheme.theme;
  final GameController _gCont = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Info(keyw: 'P', value: _gCont.points.toString()),
                Info(keyw: 'LEVEL', value: _gCont.level.toString()),
              ],
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
                  controller.update(['startButton']);
                },
                child: Text(
                  !controller.isStarted
                      ? 'Start'
                      : controller.isStarting
                      ? 'Pause'
                      : 'Resume',
                  style: TextStyle(color: _appTheme.secondaryHeaderColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
