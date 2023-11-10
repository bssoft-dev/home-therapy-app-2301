import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/routes/route_page.dart';
import 'package:home_therapy_app/utils/main_color.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        useMaterial3: true,
        colorSchemeSeed: mainColor.mainColor(),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
        brightness: Brightness.light,
      ),

      getPages: RoutePage.page,
      initialRoute: RouteName.home,
      // builder: (context, child) {
      //   return MediaQuery(

      //       data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //       child: child!);
      // },
    );
  }
}
