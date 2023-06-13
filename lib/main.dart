import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:home_therapy_app/routes.dart';
import 'package:home_therapy_app/screens/track_player.dart';
import 'package:home_therapy_app/widgets/main_color_widget.dart';

void main() {
  runApp(HomeTherapyApp());
}

class HomeTherapyApp extends StatelessWidget {
  HomeTherapyApp({super.key});
  final MainColor mainColor = MainColor();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: mainColor.mainColor(),
      ),
      initialRoute: '/',
      getPages: routeList,
      home: const trackPlayer(),
    );
  }
}
