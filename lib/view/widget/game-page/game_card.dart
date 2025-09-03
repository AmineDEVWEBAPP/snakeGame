import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';
import '../../../core/config/theme.dart';

class GameCard extends StatelessWidget {
  GameCard({super.key});
  final ThemeData _theme = AppTheme.theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.9,
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: const Color.fromARGB(255, 86, 255, 92),
          width: 2,
        ),
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

  Widget _pixel(int index) => GetBuilder<GameController>(
    id: 'snakeLocation',
    builder: (controller) => Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: controller.snakePixels.contains(index)
            ? Colors.orange
            : controller.ballLocation == index
            ? Colors.blue
            : null,
      ),
      child: Text(index.toString(), style: TextStyle(fontSize: 10)),
    ),
  );
}
