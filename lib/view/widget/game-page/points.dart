import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GetBuilder<GameController>(
        id: 'points',
        builder: (controller) => Text(
          'P : ${controller.points}',
          style: TextStyle(color: Colors.yellow, fontSize: 17),
        ),
      ),
    );
  }
}
