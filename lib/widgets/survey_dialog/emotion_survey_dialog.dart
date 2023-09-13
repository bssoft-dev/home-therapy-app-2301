import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/awakener_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? emotionList;
int emotionValue = 0;
List<int>? emotionValueList;

emotionServeyDialog({
  required BuildContext context,
  String? noiseCheckResult,
}) {
  loadAssetImages('emotion').then((value) async {
    emotionList = value;
    emotionValueList =
        List<int>.generate(emotionList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '정서가설문',
      surveyTitle: '질문 2/3',
      surveyContentTitle: '[정서가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: emotionList,
      surveyContentValueList: emotionValueList,
      surveyContentValue: emotionValue,
      surveyOnPressed: () {
        Get.back();
        awakenerServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          emotionCheckResult: emotionValue,
        );
      },
    );
  });
}
