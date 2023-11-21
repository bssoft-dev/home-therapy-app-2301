import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_noise_choice_score.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:home_therapy_app/widgets/volume_controller_widget.dart';

therapyPlay({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<int>? noiseTypeValue,
  int? noiseTypeScoreValue,
}) {
  return playTrack(
    context: context,
    trackTitle: '원하는 곡 재생',
    actionText: '다음',
    volumeSlider: const VolumeController(),
    tracks: (playTrackTitle) async {
      debugPrint(('noiseDialog:$noiseCheckResult'));
      debugPrint(('noiseType:$noiseTypeValue'));
      debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
      debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
      debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
      debugPrint(('tracks:$playTrackTitle'));
      Get.back();
      playTrackTitleTime = [];
      await postNoiseChoiceScoreDialog(
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
