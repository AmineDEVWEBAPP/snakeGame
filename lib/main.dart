import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'controller/route_controller.dart';
import 'core/config/theme.dart';
import 'core/utils/methodes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.theme,
    themeMode: AppTheme.mode,
    initialRoute: RouteController.gamePage.name,
    getPages: [RouteController.gamePage],
  );
}
