import 'package:flutter/material.dart';

Widget simpleIconButton(IconData icon, double size, void Function() onPressed) {
  return IconButton(
    icon: Icon(
      icon,
      size: size,
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
