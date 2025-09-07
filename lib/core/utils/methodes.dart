import '../../controller/theme_controller.dart';

void logger(String? message) {
  // ignore: avoid_print
  print('\x1B[34m [logger] → $message\x1B[0m');
}

Future<void> initServices() async {
  await ThemeController.init();
}

int getSpeed(int level) {
  switch (level) {
    case 1:
      return 330;
    case 2:
      return 230;
    default:
      return 130;
  }
}
