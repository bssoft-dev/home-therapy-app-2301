import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/after_awakener_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? afterEmotionList;
int afterEmotionValue = 0;
List<int>? afterEmotionValueList;
afterEmotionServeyDialog({
  required BuildContext context,
  String? noiseCheckResult,
  int? emotionCheckResult,
  int? awakenerCheckResult,
  List<String>? playTrackTitleReuslt,
}) {
  loadAssetImages('emotion').then((value) {
    afterEmotionList = value;
    afterEmotionValueList =
        List<int>.generate(afterEmotionList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 정서가설문',
      surveyTitle: '질문 2/3',
      surveyContentTitle: '[정서가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: afterEmotionList,
      surveyContentValueList: afterEmotionValueList,
      surveyContentValue: afterEmotionValue,
      surveyOnPressed: () {
        Get.back();
        afterAwakenerServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          emotionCheckResult: emotionCheckResult,
          awakenerCheckResult: awakenerCheckResult,
          playTrackTitleReuslt: playTrackTitleReuslt,
          afterEmotionCheckResult: afterEmotionValue,
        );
      },
    );
  });
}
