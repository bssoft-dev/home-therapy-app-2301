import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';
import 'package:home_therapy_app/widgets/survey_dialog/therapy_play_dialog.dart';

List<String>? awakenerList;
int awakenerValue = 0;
List<int>? awakenerValueList;
awakenerServeyDialog({
  required BuildContext context,
  String? noiseCheckResult,
  int? emotionCheckResult,
}) {
  loadAssetImages('awakener').then((value) {
    awakenerList = value;
    awakenerValueList =
        List<int>.generate(awakenerList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '각성가설문',
      surveyTitle: '질문 3/3',
      surveyContentTitle: '[각성가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: awakenerList,
      surveyContentValueList: awakenerValueList,
      surveyContentValue: awakenerValue,
      surveyOnPressed: () {
        Get.back();
        therapyPlay(
          context: context,
          noiseCheckResult: noiseCheckResult,
          emotionCheckResult: emotionCheckResult,
          awakenerCheckResult: awakenerValue,
        );
      },
    );
  });
}
