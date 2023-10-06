import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_image_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:home_therapy_app/widgets/volume_controller_widget.dart';

therapyPlay({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  String? noiseTypeValue,
  int? noiseTypeScoreValue,
}) {
  return playTrack(
    context: context,
    trackTitle: '원하는 곡 재생',
    actionText: '종료',
    volumeSlider: const VolumeController(),
    tracks: (playTrackTitle) {
      debugPrint(('noiseDialog:$noiseCheckResult'));
      debugPrint(('noiseType:$noiseTypeValue'));
      debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
      debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
      debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
      debugPrint(('tracks:$playTrackTitle'));

      return comportPlotServeyDialog(
        context: context,
        noiseCheckResult: noiseCheckResult,
        noiseTypeValue: noiseTypeValue,
        noiseTypeScoreValue: noiseTypeScoreValue,
        preEmotionCheckResult: preEmotionCheckResult,
        preAwakeCheckResult: preAwakeCheckResult,
        playTrackTitleReuslt: playTrackTitle,
      );
    },
  );
}
