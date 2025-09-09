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
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: BoxBorder.all(color: _theme.secondaryHeaderColor, width: 2),
          color: _theme.focusColor,
        ),
        child: GetBuilder<GameController>(
          id: 'snakeLocation',
          builder: (controller) => GridView.builder(
            padding: EdgeInsets.all(0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 15,
              childAspectRatio: 1,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 225,
            itemBuilder: (context, i) => _pixel(i),
          ),
        ),
      ),
    );
  }

  Widget _pixel(int index) => GetBuilder<SnakeController>(
    id: 'pixel',
    builder: (controller) => Container(
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(controller.ball == index ? 200 : 0),
        color: controller.pixelColor(index),
      ),
      // child: Text('$index', style: TextStyle(fontSize: 10)),
    ),
  );
}
