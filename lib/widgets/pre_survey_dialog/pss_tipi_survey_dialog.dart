import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';

int valueP = 0;
int valueT = 0;
List<int> selectedPValues = List.generate(pssQ.length, (index) => 0);
List<int> selectedTValues = List.generate(tipiQ.length, (index) => 0);

pssServeyDialogQ({
  required BuildContext context,
  required List<int> selectedA1Values,
  required List<int> selectedA2Values,
  required List<int> selectedA3Values,
  required List<int> selectedA4Values,
  required List<int> selectedA5Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '스트레스 평가-PSS(perceived stress scale)',
      surveyTitle: '최근 1개월간의 스트레스를 평가해주십시오.',
      questionTitle: pssQ,
      note: note,
      noteNumber: 3,
      radioNumber: 5,
      questionNumber: pssQ.length,
      questionResultList: selectedPValues,
      questionValue: valueP,
      surveyOnPressed: () {
        Get.back();
        tipiServeyDialogQ(
            context: context,
            selectedA1Values: selectedA1Values,
            selectedA2Values: selectedA2Values,
            selectedA3Values: selectedA3Values,
            selectedA4Values: selectedA4Values,
            selectedA5Values: selectedA5Values,
            selectedPValues: selectedPValues);
      },
      onSurveyContentValueChange: (value) {
        valueP = value;
      });
}

tipiServeyDialogQ({
  required BuildContext context,
  required List<int> selectedA1Values,
  required List<int> selectedA2Values,
  required List<int> selectedA3Values,
  required List<int> selectedA4Values,
  required List<int> selectedA5Values,
  required List<int> selectedPValues,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '스트레스 평가-PSS(perceived stress scale)',
      surveyTitle: '최근 1개월간의 스트레스를 평가해주십시오.',
      questionTitle: tipiQ,
      note: note,
      noteNumber: 4,
      radioNumber: 7,
      questionNumber: tipiQ.length,
      questionResultList: selectedTValues,
      questionValue: valueT,
      surveyOnPressed: () {
        Get.back();
        debugPrint('$selectedA1Values');
        debugPrint('$selectedA2Values');
        debugPrint('$selectedA3Values');
        debugPrint('$selectedA4Values');
        debugPrint('$selectedA5Values');
        debugPrint('$selectedPValues');
        debugPrint('$selectedTValues');
      },
      onSurveyContentValueChange: (value) {
        valueT = value;
      });
}
