import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';
import '../../../controller/snake_controller.dart';
import '../../../controller/theme_controller.dart';

class GameCard extends StatelessWidget {
  GameCard({super.key});
  final ThemeData _theme = ThemeController.theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.9,
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: _theme.secondaryHeaderColor, width: 2),
        color: _theme.focusColor,
      ),
      child: GetBuilder<GameController>(
        id: 'snakeLocation',
        builder: (controller) => GridView.builder(
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 25,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 225,
          itemBuilder: (context, i) => _pixel(i),
        ),
      ),
    );
  }

  Widget _pixel(int index) => GetBuilder<SnakeController>(
    id: 'pixel',
    builder: (controller) => Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: controller.pixels.contains(index)
            ? controller.head == index
                  ? Colors.pink
                  : Colors.orange
            : controller.ball == index
            ? Colors.blue
            : null,
      ),
      child: Text(index.toString(), style: TextStyle(fontSize: 10)),
    ),
  );
}
