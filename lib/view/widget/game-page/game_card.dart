import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';
import '../../../controller/snake_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../core/const/consts.dart';

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
        color: controller.pixels.contains(index)
            ? controller.head == index
                  ? Colors.transparent
                  : Colors.orange
            : controller.ball == index
            ? Colors.blue
            : null,
      ),
      // child: Text('$index', style: TextStyle(fontSize: 10)),
      child: controller.head == index ? SvgPicture.asset(headPath) : null,
    ),
  );
}
