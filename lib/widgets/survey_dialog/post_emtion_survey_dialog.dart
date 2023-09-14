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
  List<dynamic>? comportPlotResult,
  int? postEmotionCheckResult,
}) {
  loadAssetImages('emotion').then((value) {
    postEmotionList = value;
    postEmotionValueList =
        List<int>.generate(postEmotionList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 정서가설문',
      surveyTitle: '질문 2/3',
      surveyContentTitle: '[정서가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: postEmotionList,
      surveyContentValueList: postEmotionValueList,
      surveyContentValue: postEmotionValue,
      onSurveyContentValueChange: (value) => postEmotionValue = value,
      surveyOnPressed: () async {
        Get.back();
        print('noiseDialog:$noiseCheckResult');
        print('trackplay:$playTrackTitleReuslt');
        print('emotionDialog:$preEmotionCheckResult');
        print('awakeDialog:$preAwakeCheckResult');
        print('comportPlot:$comportPlotResult');
        print('PostemotionDialog:$postEmotionValue');

        await postAwakeServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          preEmotionCheckResult: preEmotionCheckResult,
          preAwakeCheckResult: preAwakeCheckResult,
          playTrackTitleReuslt: playTrackTitleReuslt,
          comportPlotResult: comportPlotResult,
          postEmotionCheckResult: postEmotionValue,
        );
      },
    );
  });
}
