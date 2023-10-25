import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_awakener_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? postEmotionList;
int postEmotionValue = 0;
List<int>? postEmotionValueList;
postEmotionServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<dynamic>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  int? noiseTypeValue,
  int? noiseTypeScoreValue,
 List? comportPlotResult,
}) {
  loadAssetSVGs('emotion').then((value) {
    postEmotionList = value;
    postEmotionValueList =
        List<int>.generate(postEmotionList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 정서가설문',
      surveyTitle: '질문 2/3',
      surveyContentTitle: '[정서가]',
      surveyContent: '현재 본인과 가장 알맞는 감정 상태를 고르시오',
      surveyImageList: postEmotionList,
      surveyContentValueList: postEmotionValueList,
      surveyContentValue: postEmotionValue,
      onSurveyContentValueChange: (value) => postEmotionValue = value,
      surveyOnPressed: () async {
        Get.back();
        debugPrint(('noiseDialog:$noiseCheckResult'));
        debugPrint(('noiseType:$noiseTypeValue'));
        debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
        debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
        debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
        debugPrint(('tracks:$playTrackTitleReuslt'));
        debugPrint(('comportPlotDialog:$comportPlotResult'));
        debugPrint(('PostemotionDialog:$postEmotionValue'));

        await postAwakeServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          noiseTypeValue: noiseTypeValue,
          noiseTypeScoreValue: noiseTypeScoreValue,
          preEmotionCheckResult: preEmotionCheckResult,
          preAwakeCheckResult: preAwakeCheckResult,
          playTrackTitleReuslt: playTrackTitleReuslt,
          comportPlotResult: comportPlotResult,
          postEmotionCheckResult: postEmotionValue,
        );
        postEmotionValue = 0;
      },
    );
  });
}
