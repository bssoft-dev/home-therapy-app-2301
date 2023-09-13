import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/survey_dialog/after_image_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:home_therapy_app/widgets/volume_controller_widget.dart';

therapyPlay({
  required BuildContext context,
  String? noiseCheckResult,
  int? emotionCheckResult,
  int? awakenerCheckResult,
}) {
  return playTrack(
    context: context,
    trackTitle: '음원목록',
    actionText: '종료',
    volumeSlider: const VolumeController(),
    afterSurvey: (playTrackTitle) {
      return imageEmotionServeyDialog(
        context: context,
        noiseCheckResult: noiseCheckResult,
        emotionCheckResult: emotionCheckResult,
        awakenerCheckResult: awakenerCheckResult,
        playTrackTitleReuslt: playTrackTitle,
      );
    },
  );
}
