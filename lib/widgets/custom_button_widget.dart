import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/main_color.dart';

final MainColor mainColor = MainColor();

Widget simpleOutlineButton(
    String text, IconData icon, double size, void Function() onPressed) {
  return OutlinedButton.icon(
    label: Text(
      text,
      style: TextStyle(color: mainColor.mainColor()),
    ),
    icon: Icon(
      icon,
      size: size,
      color: mainColor.mainColor(),
    ),
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: mainColor.mainColor()),
    ),
  );
}

Widget button(
    String text, IconData icon, double size, void Function() onPressed) {
  return ElevatedButton.icon(
    label: Text(
      text,
      style: TextStyle(color: mainColor.mainColor()),
    ),
    icon: Icon(
      icon,
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
    ),
    onPressed: onPressed,
  );
}
