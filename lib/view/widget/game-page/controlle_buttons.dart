import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/game_controller.dart';
import '../../../core/config/theme.dart';

// ignore: must_be_immutable
class ControlleButtons extends StatelessWidget {
  ControlleButtons({super.key});
  final GameController _gContr = Get.find<GameController>();
  final ThemeData _appTheme = AppTheme.theme;
  double bSize = (Get.width * 0.45) / 3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.45,
      height: Get.width * 0.45,
      child: Row(
        children: [
          _left(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_top(), _bottom()],
          ),
          _right(),
        ],
      ),
    );
  }

  Widget _left() => InkWell(
    onTap: _gContr.toLeft,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: _appTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.arrow_back_ios_new),
    ),
  );
  Widget _right() => InkWell(
    onTap: _gContr.toRight,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: _appTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.arrow_forward_ios),
    ),
  );
  Widget _top() => InkWell(
    onTap: _gContr.toTop,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: _appTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(quarterTurns: 1, child: Icon(Icons.arrow_back_ios_new)),
    ),
  );
  Widget _bottom() => InkWell(
    onTap: _gContr.toBottom,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: _appTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: -1,
        child: Icon(Icons.arrow_back_ios_new),
      ),
    ),
  );
}
