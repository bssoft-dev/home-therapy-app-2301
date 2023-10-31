import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/version_model.dart';
import 'package:home_therapy_app/utils/assets_image_list_future.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_word_position_survey_dialog.dart';

List<String>? postAwakeList;
int postAwakeValue = 0;
List<int>? postAwakeValueList;
VersionCurrent currentVersion = VersionCurrent();
postAwakeServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<Map<String, dynamic>>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  int? noiseTypeValue,
  int? noiseTypeScoreValue,
  int? postNoise,
  // List? wordPositionResult,
  // int? wordPositionRatingResult,
  // String? wordPositionTitleResult,
}) {
  loadAssetSVGs('awakener').then((value) {
    postAwakeList = value;
    postAwakeValueList =
        List<int>.generate(postAwakeList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 각성가설문',
      surveyTitle: '질문 3/4',
      surveyContentTitle: '[각성가]',
      surveyContent: '현재 본인과 가장 알맞는 감정 상태를 고르시오',
      surveyImageList: postAwakeList,
      surveyContentValueList: postAwakeValueList,
      surveyContentValue: postAwakeValue,
      onSurveyContentValueChange: (value) => postAwakeValue = value,
      surveyOnPressed: () async {
        Get.back();
        debugPrint(('noiseDialog:$noiseCheckResult'));
        debugPrint(('noiseType:$noiseTypeValue'));
        debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
        debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
        debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
        debugPrint(('tracks:$playTrackTitleReuslt'));
        debugPrint(('postEmotionCheckResult:$postEmotionCheckResult'));
        debugPrint(('postAwakeValue:$postAwakeValue'));
        await postWordPositionServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          noiseTypeValue: noiseTypeValue,
          noiseTypeScoreValue: noiseTypeScoreValue,
          preEmotionCheckResult: preEmotionCheckResult,
          preAwakeCheckResult: preAwakeCheckResult,
          playTrackTitleReuslt: playTrackTitleReuslt,
          // wordPositionResult: wordPositionResult,
          postEmotionCheckResult: postEmotionCheckResult,
          postAwakeValue: postAwakeValue,
          postNoise: postNoise,
        );
        postAwakeValue = 0;
      },
    );
  });
}
