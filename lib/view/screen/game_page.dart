import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/config/theme.dart';
import '../widget/game-page/controlle_buttons.dart';
import '../widget/game-page/points.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});
  final ThemeData _theme = AppTheme.theme;
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
            Container(
              height: Get.height * 0.45,
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  color: const Color.fromARGB(255, 86, 255, 92),
                  width: 2,
                ),
                color: _theme.cardColor,
              ),
            ),
            SizedBox(height: 40),
            ControlleButtons(),
          ],
        ),
      ),
    );
  }
}
