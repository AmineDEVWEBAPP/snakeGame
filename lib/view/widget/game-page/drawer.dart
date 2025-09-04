import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';
import '../../../core/config/theme.dart';

class GameDrawer extends StatelessWidget {
  GameDrawer({super.key});

  final ThemeData _theme = AppTheme.theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.25,
      width: Get.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: _theme.hintColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<GameController>(
            id: 'info',
            builder: (controller) =>
                _button(Icons.leaderboard, 'level ${controller.level}', () {}),
          ),
          _button(Icons.score, 'top score', () {}),
          _button(Icons.contrast, 'them Mode', () {}),
          _button(Icons.info, 'about dev', () {}),
        ],
      ),
    );
  }

  Widget _button(IconData icon, String label, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: _theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: Get.width * 0.1),
            Text(label),
          ],
        ),
      ),
    );
  }
}
