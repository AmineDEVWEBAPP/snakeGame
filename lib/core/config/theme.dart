import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/methodes.dart';

class AppTheme {
  AppTheme._();
  static final AppTheme _instance = AppTheme._();
  late SharedPreferences shp;
  static late ThemeMode mode;
  static late ThemeData theme;

  static init() async {
    logger('init Theme');
    _instance.shp = await SharedPreferences.getInstance();
    await _instance.getTheme();
  }

  static void changeMode(ThemeMode mode) {
    logger('change themeMode to ${mode.name}');
    AppTheme.mode = mode;
    _instance.shp.setString('mode', mode.name);
    Get.appUpdate();
  }

  Future<void> getMode() async {
    String? modeName = _instance.shp.getString('mode');
    switch (modeName) {
      case 'dark':
        AppTheme.mode = ThemeMode.dark;
      case 'light':
        AppTheme.mode = ThemeMode.light;
      default:
        AppTheme.mode = ThemeMode.dark;
    }
  }

  Future<void> getTheme() async {
    await _instance.getMode();
    AppTheme.mode == ThemeMode.dark
        ? AppTheme.theme = _darkTheme
        : AppTheme.theme = _lightTheme;
  }

  final ThemeData _lightTheme = ThemeData();
  final ThemeData _darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 22, 22, 22),
    focusColor: const Color.fromARGB(255, 38, 38, 38),
    cardColor: Colors.white38,
    secondaryHeaderColor: Colors.yellow,
    hintColor: const Color.fromARGB(255, 97, 97, 97),
    textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.yellow)),
    iconTheme: IconThemeData(color: Colors.yellow),
  );
}
