import 'dart:ui';

import 'package:flutter/material.dart';

Widget backgroundContainer({
  required BuildContext context,
  required Widget child,
}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/app_background.png"),
        fit: BoxFit.fill,
      ),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: child,
    ),
  );
}
