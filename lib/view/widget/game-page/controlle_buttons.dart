import 'package:flutter/material.dart';

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
    final Size size = MediaQuery.sizeOf(context);
    final double cardSize = ((size.width + size.height) / 2) * 0.35;
    return SizedBox(
      width: cardSize,
      height: cardSize,
      child: Row(
        children: [
          _button(left, cardSize: cardSize),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _button(top, turns: 1, cardSize: cardSize),
              _button(bottom, turns: -1, cardSize: cardSize),
            ],
          ),
          _button(right, turns: 2, cardSize: cardSize),
        ],
      ),
    );
  }

  Widget _button(
    void Function() onTap, {
    int? turns,
    required double cardSize,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: cardSize / 3,
      height: cardSize / 3,
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
