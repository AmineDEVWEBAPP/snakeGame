import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../widget/game-page/controlle_buttons.dart';
import '../widget/game-page/game_card.dart';
import '../widget/game-page/points.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final GameController _gContr = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1),
            Points(),
            GameCard(),
            SizedBox(height: 40),
            ControlleButtons(),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                _gContr.start();
              },
              child: Text('Start'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _gContr.stop();
              },
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
