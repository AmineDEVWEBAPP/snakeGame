import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({super.key, required this.onTap});
  final void Function() onTap;

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
            turns: controller.iconTurns,
            duration: const Duration(milliseconds: 400),
            child: Icon(Icons.settings),
          ),
        ),
      ),
    );
  }
}
