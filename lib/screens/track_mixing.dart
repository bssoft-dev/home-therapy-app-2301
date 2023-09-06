import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';

class TrackMixing extends StatefulWidget {
  const TrackMixing({super.key});

  @override
  State<TrackMixing> createState() => _TrackMixingState();
}

class _TrackMixingState extends State<TrackMixing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundContainer(
        context: context,
        child: Column(
          children: [
            trackList(),
          ],
        ),
      ),
    );
  }
}
