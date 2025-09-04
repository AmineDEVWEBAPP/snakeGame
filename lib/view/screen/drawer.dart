import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../../controller/theme_controller.dart';
import '../widget/drawer/expanded_dialog.dart';

class GameDrawer extends StatefulWidget {
  const GameDrawer({super.key});

  @override
  State<GameDrawer> createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  final ThemeData _theme = ThemeController.theme;
  bool _openLevels = false;
  bool _openModes = false;
  double _dialogHeight = Get.height * 0.185;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _dialogHeight,
      width: Get.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: _theme.hintColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            GetBuilder<GameController>(
              id: 'info',
              builder: (controller) =>
                  _button(Icons.leaderboard, 'level ${controller.level}', () {
                    _openLevels = !_openLevels;
                    _openLevels
                        ? _dialogHeight = Get.height * 0.25
                        : _dialogHeight = Get.height * 0.185;
                    setState(() {});
                  }),
            ),
            ExpandedDialog(
              offset: Offset(0, -Get.height * 0.025),
              isOpen: _openLevels,
              data: [
                {'Level 1': 1},
                {'Level 2': 2},
                {'Level 3': 3},
              ],
              onTap: (v) {
                _openLevels = false;
                _dialogHeight = Get.height * 0.25;
                setState(() {});
              },
            ),
            _button(Icons.score, 'top score', () {
              Get.defaultDialog(
                title: 'Top score',
                middleText: '2993',
                backgroundColor: _theme.hintColor,
                titleStyle: TextStyle(fontSize: 15),
                middleTextStyle: TextStyle(fontSize: 30),
              );
            }),
            _button(Icons.contrast, 'them Mode', () {
              _openModes = !_openModes;
              _openModes
                  ? _dialogHeight = Get.height * 0.31
                  : _dialogHeight = Get.height * 0.185;
              setState(() {});
            }),
            ExpandedDialog(
              offset: Offset(0, -Get.height * 0.025),

              isOpen: _openModes,
              data: [
                {'dark': ThemeMode.dark},
                {'light': ThemeMode.light},
              ],
              onTap: (v) {
                _openModes = false;
                _dialogHeight = Get.height * 0.185;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(IconData icon, String label, void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        margin: EdgeInsets.only(bottom: Get.height * 0.025),
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
