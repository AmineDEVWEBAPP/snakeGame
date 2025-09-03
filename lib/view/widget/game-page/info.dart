import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';

class Info extends StatelessWidget {
  const Info({super.key, required this.keyw, required this.value});
  final String keyw;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: GetBuilder<GameController>(
        id: 'info',
        builder: (controller) => Text(
          '$keyw : $value',
          style: TextStyle(color: Colors.yellow, fontSize: 17),
        ),
      ),
    );
  }
}
