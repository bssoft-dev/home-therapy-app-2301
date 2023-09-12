import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/survey_dialog/after_image_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:home_therapy_app/widgets/volume_controller_widget.dart';

String emotionValueInit = '행복';
Future<bool>? asyncMethodFuture;
double currentVolume = 50;

therapyPlay({
  required BuildContext context,
}) {
  asyncMethodFuture = asyncTrackPlayListMethod();
  return playTrack(
    context: context,
    trackTitle: '음원목록',
    actionText: '종료',
    volumeSlider: const VolumeController(),
    afterSurvey: imageEmotionServeyDialog(context: context),
  );
}
