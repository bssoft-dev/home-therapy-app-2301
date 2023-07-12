import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/routes/route_page.dart';
import 'package:home_therapy_app/widgets/main_color_widget.dart';

void main() {
  runApp(HomeTherapyApp());
}

// ignore: must_be_immutable
class HomeTherapyApp extends StatelessWidget {
  HomeTherapyApp({super.key});
  final MainColor mainColor = MainColor();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: mainColor.mainColor(),
        ),
        getPages: RoutePage.page,
        initialRoute: RouteName.home);
  }
}
