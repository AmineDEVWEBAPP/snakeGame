import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/theme_controller.dart';

class ControlleButtons extends StatelessWidget {
  ControlleButtons({
    super.key,
    required this.left,
    required this.top,
    required this.bottom,
    required this.right,
  });
  final ThemeData _appTheme = ThemeController.theme;
  final void Function() left;
  final void Function() top;
  final void Function() bottom;
  final void Function() right;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.45,
      height: Get.width * 0.45,
      child: Row(
        children: [
          _button(left),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_button(top, turns: 1), _button(bottom, turns: -1)],
          ),
          _button(right, turns: 2),
        ],
      ),
    );
  }

  Widget _button(void Function() onTap, {int? turns}) => InkWell(
    onTap: onTap,
    child: Container(
      width: (Get.width * 0.45) / 3,
      height: (Get.width * 0.45) / 3,
      decoration: BoxDecoration(
        color: _appTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: turns ?? 0,
        child: Icon(Icons.arrow_back_ios_new),
      ),
    ),
  );
}
