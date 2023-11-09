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
  Color activeColor =
      isPlaying ? mainColor.mainColor() : const Color(0xff5a5a5a);
  return OutlinedButton.icon(
    label: Text(
      text,
      style: TextStyle(color: activeColor),
    ),
    icon: Icon(
      isPlaying ? alternateIcon : icon,
      size: size,
      color: activeColor,
    ),
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: activeColor),
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
      color: isPlaying ? mainColor.mainColor() : const Color(0xff5a5a5a),
    ),
    onPressed: onPressed,
  );
}

Widget changeIconButton({
  required IconData icon,
  required double size,
  required bool isChange,
  required Color iconColor,
  required Color alternateIconColor,
  required void Function() onPressed,
}) {
  return IconButton(
    icon: Icon(
      icon,
      size: size,
      color: isChange ? alternateIconColor : iconColor,
    ),
    onPressed: onPressed,
  );
}
