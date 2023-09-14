import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_awakener_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? preEmotionList;
int preEmotionValue = 0;
List<int>? preEmotionValueList;

preEmotionServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
}) {
  loadAssetImages('emotion').then((value) async {
    preEmotionList = value;
    preEmotionValueList =
        List<int>.generate(preEmotionList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '정서가설문',
      surveyTitle: '질문 2/3',
      surveyContentTitle: '[정서가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: preEmotionList,
      surveyContentValueList: preEmotionValueList,
      surveyContentValue: preEmotionValue,
      onSurveyContentValueChange: (value) => preEmotionValue = value,
      surveyOnPressed: () {
        Get.back();
        preAwakeServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          preEmotionCheckResult: preEmotionValue,
        );
        debugPrint(('noiseDialog:$noiseCheckResult'));
        debugPrint(('PreemotionDialog:$preEmotionValue'));
      },
    );
  });
}
