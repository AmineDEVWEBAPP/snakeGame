import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller.dart';
import '../../../core/config/theme.dart';

class DrawerIcon extends StatelessWidget {
  DrawerIcon({super.key, required this.onTap});
  final void Function() onTap;

  final ThemeData _theme = AppTheme.theme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: GetBuilder<GameDrawerController>(
          id: 'drawerIcon',
          builder: (controller) => AnimatedRotation(
            turns: controller.turns,
            duration: const Duration(milliseconds: 400),
            child: Icon(Icons.settings, color: _theme.secondaryHeaderColor),
          ),
        ),
      ),
    );
  }
}
