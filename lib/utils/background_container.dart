import 'package:flutter/material.dart';

Widget backgroundContainer(BuildContext context, Widget child) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/appBackground.png"),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
