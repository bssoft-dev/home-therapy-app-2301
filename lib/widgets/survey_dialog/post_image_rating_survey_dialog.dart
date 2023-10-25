import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_emtion_survey_dialog.dart';

List<Map<String, dynamic>> comportValueResult = [];
String comportPlotTitleValue ='';
int comportPlotRatingValue = 0;

List<int> selectedValues = List.generate(comportPlotText.length, (index) => 0);

postComportPlotRatingServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<dynamic>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  String? noiseTypeValue,
  int? noiseTypeScoreValue,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '소리와 공간에 맞는 단어 위치 선택 설문',
      surveyTitle: '각 단어가 현재 들리는 소리와 공간의 상황에 어울리는 정도를 평가해주십시오.',
      questionTitle: comportPlotText,
      noteNumber: 0,
      radioNumber: 7,
      questionNumber: comportPlotText.length,
      questionResultList: selectedValues,
      questionValue: comportPlotRatingValue,
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
            comportPlotResult: comportValueResult
            );

        debugPrint(('noiseDialog:$noiseCheckResult'));
        debugPrint(('noiseType:$noiseTypeValue'));
        debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
        debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
        debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
        debugPrint(('tracks:$playTrackTitleReuslt'));
        debugPrint(('comportPlotDialog:$comportValueResult'));
        selectedValues =List.generate(comportPlotText.length, (index) => 0);
        comportValueResult = [];
      },
      onSurveyContentValueChange:(value) => debugPrint('사용하지않음'),
      onSurveyMapValueChange: (value) {
        comportPlotTitleValue =  comportPlotText[value.titleValue];
        comportPlotRatingValue = value.ratingValue;
        saveTocomportValueResult(comportPlotTitleValue, comportPlotRatingValue);
      },
      );
}

void saveTocomportValueResult(String title, dynamic rating) {
  // Check if the title already exists in comportValueResult
  int existingIndex = -1;
  for (int i = 0; i < comportValueResult.length; i++) {
    Map<String, dynamic> entry = comportValueResult[i];
    if (entry.containsKey(title)) {
      // The title already exists; update the rating and store the index
      existingIndex = i;
      break;
    }
  }

  if (existingIndex != -1) {
    // If the title exists, update the rating
    comportValueResult[existingIndex][title] = rating;
  } else {
    // If the title doesn't exist, add a new entry
    Map<String, dynamic> data = {title: rating};
    comportValueResult.add(data);
  }
}

