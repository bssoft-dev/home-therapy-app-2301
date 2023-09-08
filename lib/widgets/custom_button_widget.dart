import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/main_color.dart';

final MainColor mainColor = MainColor();

Widget simpleOutlineButton({
  required String text,
  required IconData icon,
  required double size,
  required void Function() onPressed,
  required bool isPlaying,
  IconData? alternateIcon,
}) {
  return OutlinedButton.icon(
    label: Text(
      text,
      style: TextStyle(color: mainColor.mainColor()),
    ),
    icon: Icon(
      isPlaying ? alternateIcon : icon,
      size: size,
      color: mainColor.mainColor(),
    ),
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: mainColor.mainColor()),
    ),
  );
}

Widget simpleIconButton(
    IconData icon, double size, Color iconColor, void Function() onPressed) {
  return IconButton(
    icon: Icon(
      icon,
      size: size,
      color: iconColor,
    ),
    onPressed: onPressed,
  );
}

Widget playIconButton(
  IconData icon,
  IconData alternateIcon,
  double size,
  bool isPlaying,
  void Function() onPressed,
) {
  return IconButton(
    icon: Icon(
      isPlaying ? alternateIcon : icon,
      size: size,
      color: mainColor.mainColor(),
    ),
    onPressed: onPressed,
  );
}
