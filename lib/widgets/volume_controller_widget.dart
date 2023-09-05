import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/track_player_dialog_widget.dart';

class VolumeController extends StatefulWidget {
  const VolumeController({super.key});

  @override
  State<VolumeController> createState() => _VolumeControllerState();
}

class _VolumeControllerState extends State<VolumeController> {
  double currentVolume = 50;
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.onlyForContinuous),
      child: Slider(
          label: currentVolume.toInt().toString(),
          value: currentVolume,
          max: 100,
          onChanged: (double value) {
            setState(() {
              currentVolume = value;
              volumeChange(currentVolume.toInt());
            });
          }),
    );
  }
}
