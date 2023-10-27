import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_emtion_survey_dialog.dart';

int wordPositionTitleValue = 0;
int wordPositionRatingValue = 0;
List comportValueResult = List.generate(wordPositionText.length, (index) => 0);
List<int> selectedValues = List.generate(wordPositionText.length, (index) => 0);

postWordPositionServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<Map<String, dynamic>>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  int? noiseTypeValue,
  int? noiseTypeScoreValue,
}) {
  return preCommonSurveyDialog(
    context: context,
    dialogName: '소리와 공간에 맞는 단어 위치 선택 설문',
    surveyTitle: '각 단어가 현재 들리는 소리와 공간의 상황에 어울리는 정도를 평가해주십시오.',
    questionTitle: wordPositionText,
    noteNumber: 0,
    radioNumber: 7,
    questionNumber: wordPositionText.length,
    questionResultList: selectedValues,
    questionValue: wordPositionRatingValue,
    surveyOnPressed: () async {
      Get.back();
      await postEmotionServeyDialog(
          context: context,
          noiseCheckResult: noiseCheckResult,
          noiseTypeValue: noiseTypeValue,
          noiseTypeScoreValue: noiseTypeScoreValue,
          preEmotionCheckResult: preEmotionCheckResult,
          preAwakeCheckResult: preAwakeCheckResult,
          playTrackTitleReuslt: playTrackTitleReuslt,
          wordPositionResult: comportValueResult);

      debugPrint(('noiseDialog:$noiseCheckResult'));
      debugPrint(('noiseType:$noiseTypeValue'));
      debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
      debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
      debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
      debugPrint(('tracks:$playTrackTitleReuslt'));
      debugPrint(('wordPositionDialog:$comportValueResult'));
      selectedValues = List.generate(wordPositionText.length, (index) => 0);
      comportValueResult = List.generate(wordPositionText.length, (index) => 0);
    },
    onSurveyContentValueChange: (value) => debugPrint('사용하지않음'),
    onSurveyMapValueChange: (value) {
      wordPositionTitleValue = value.titleValue;
      wordPositionRatingValue = value.ratingValue;
      comportValueResult[value.titleValue] = value.ratingValue;
    },
  );
}
