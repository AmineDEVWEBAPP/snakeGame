import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/game_controller.dart';
import '../../controller/theme_controller.dart';
import '../widget/drawer/button.dart';

class GameDrawer extends StatefulWidget {
  const GameDrawer({super.key});

  @override
  State<GameDrawer> createState() => _GameDrawerState();
}

class _GameDrawerState extends State<GameDrawer> {
  final ThemeData _theme = ThemeController.theme;
  final GameController _gContr = Get.find<GameController>();
  bool _openLevels = false;
  bool _openModes = false;
  bool _openSound = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: _theme.hintColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<GameController>(
            id: 'info',
            builder: (controller) => GameDrawerButton(
              icon: Icons.leaderboard,
              title: 'level ${controller.level}',
              onTap: () {
                _openLevels = !_openLevels;
                setState(() {});
              },
              isOpen: _openLevels,
              onChoice: (level) async {
                _openLevels = false;
                setState(() {});
                await _gContr.changeLevel(level);
              },
              data: [
                {'Level 1': 1},
                {'Level 2': 2},
                {'Level 3': 3},
              ],
              groupValue: controller.level,
            ),
          ),
          Divider(),
          _button(Icons.score, 'top score', () {
            Get.defaultDialog(
              title: 'Top score',
              middleText: _gContr.topScore.toString(),
              backgroundColor: _theme.hintColor,
              titleStyle: TextStyle(fontSize: 15),
              middleTextStyle: TextStyle(fontSize: 30),
            );
          }, size),
          Divider(),
          GameDrawerButton(
            icon: Icons.volume_up,
            title: 'sound effect',
            onTap: () {
              _openSound = !_openSound;
              setState(() {});
            },
            isOpen: _openSound,
            onChoice: (auth) {
              _openSound = false;
              setState(() {});
              _gContr.changeSoundePerm(auth);
            },
            data: [
              {'turn on': true},
              {'turn off': false},
            ],
            groupValue: _gContr.allowSounde,
          ),
          Divider(),
          GameDrawerButton(
            icon: Icons.contrast,
            title: 'theme mode',
            onTap: () {
              _openModes = !_openModes;
              setState(() {});
            },
            isOpen: _openModes,
            onChoice: (mode) {
              _openModes = false;
              setState(() {});
              _showModeDialog(mode);
            },
            data: [
              {'dark': ThemeMode.dark},
              {'light': ThemeMode.light},
            ],
            groupValue: ThemeController.mode,
          ),
        ],
      ),
    );
  }

  Widget _button(
    IconData icon,
    String label,
    void Function() onTap,
    Size size,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.038,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: _theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: size.width * 0.1),
            Text(label),
          ],
        ),
      ),
    );
  }

  Future _showModeDialog(ThemeMode mode) async => await Get.defaultDialog(
    title: '',
    titleStyle: const TextStyle(inherit: false, fontSize: 0, height: 0),
    middleText:
        'pleas restart the game for change\n theme mode to ${mode.name}',
    backgroundColor: _theme.hintColor,
    confirm: FilledButton(
      onPressed: () async {
        await ThemeController.changeMode(mode);
        exit(1);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(_theme.scaffoldBackgroundColor),
      ),
      child: Text('restart', style: _theme.textTheme.bodyMedium),
    ),
    cancel: FilledButton(
      onPressed: () {
        Get.back();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(_theme.cardColor),
      ),
      child: Text('cancel', style: _theme.textTheme.bodyMedium),
    ),
  );
}
