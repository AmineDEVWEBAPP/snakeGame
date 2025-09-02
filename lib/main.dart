import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'controller/route_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    initialRoute: RouteController.gamePage.name,
    getPages: [RouteController.gamePage],
  );
}
