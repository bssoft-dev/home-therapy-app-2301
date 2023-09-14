import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';

int valueQ1 = 0;
int valueQ2 = 0;
int valueQ3 = 0;
int valueQ4 = 0;
int valueQ5 = 0;

int listQ1_2Count = 10;
int listQ3_4Count = 8;
int listQ5Count = 6;

List<int> selectedQ1Values = List.generate(listQ1_2Count, (index) => 0);
List<int> selectedQ2Values = List.generate(listQ1_2Count, (index) => 0);
List<int> selectedQ3Values = List.generate(listQ3_4Count, (index) => 0);
List<int> selectedQ4Values = List.generate(listQ3_4Count, (index) => 0);
List<int> selectedQ5Values = List.generate(listQ5Count, (index) => 0);

apartmentNoiseServeyDialogQ1({
  required BuildContext context,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도1',
      surveyTitle: '1. 현재 거주 중인 곳에서 다음의 각 소음이 얼마나 자주 들리는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ1_2,
      note: note,
      noteNumber: 0,
      questionNumber: listQ1_2Count,
      questionResultList: selectedQ1Values,
      questionValue: valueQ1,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ2(
            context: context, selectedQ1Values: selectedQ1Values);
      },
      onSurveyContentValueChange: (value) {
        valueQ1 = value;
      });
}

apartmentNoiseServeyDialogQ2({
  required BuildContext context,
  required List<int> selectedQ1Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도2',
      surveyTitle: '2. 현재 거주 중인 곳에서 다음의 각 소음이 얼마나 신경쓰이는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ1_2,
      note: note,
      noteNumber: 1,
      questionNumber: listQ1_2Count,
      questionResultList: selectedQ2Values,
      questionValue: valueQ2,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ3(
            context: context,
            selectedQ1Values: selectedQ1Values,
            selectedQ2Values: selectedQ2Values);
      },
      onSurveyContentValueChange: (value) {
        valueQ2 = value;
      });
}

apartmentNoiseServeyDialogQ3({
  required BuildContext context,
  required List<int> selectedQ1Values,
  required List<int> selectedQ2Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도3',
      surveyTitle: '3. 현재 거주 중인 곳에서 다음의 각 소리가 얼마나 자주 들리는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ3_4,
      note: note,
      noteNumber: 0,
      questionNumber: listQ3_4Count,
      questionResultList: selectedQ3Values,
      questionValue: valueQ3,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ4(
            context: context,
            selectedQ1Values: selectedQ1Values,
            selectedQ2Values: selectedQ2Values,
            selectedQ3Values: selectedQ3Values);
      },
      onSurveyContentValueChange: (value) {
        valueQ3 = value;
      });
}

apartmentNoiseServeyDialogQ4({
  required BuildContext context,
  required List<int> selectedQ1Values,
  required List<int> selectedQ2Values,
  required List<int> selectedQ3Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도4',
      surveyTitle: '4. 현재 거주 중인 곳에서 다음의 각 소리가 얼마나 신경쓰이는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ3_4,
      note: note,
      noteNumber: 1,
      questionNumber: listQ3_4Count,
      questionResultList: selectedQ4Values,
      questionValue: valueQ4,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ5(
            context: context,
            selectedQ1Values: selectedQ1Values,
            selectedQ2Values: selectedQ2Values,
            selectedQ3Values: selectedQ3Values,
            selectedQ4Values: selectedQ4Values);
      },
      onSurveyContentValueChange: (value) {
        valueQ4 = value;
      });
}

apartmentNoiseServeyDialogQ5({
  required BuildContext context,
  required List<int> selectedQ1Values,
  required List<int> selectedQ2Values,
  required List<int> selectedQ3Values,
  required List<int> selectedQ4Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도5',
      surveyTitle: '5. 소음민감도.',
      questionTitle: apartmentNoiseQ5,
      note: note,
      noteNumber: 2,
      questionNumber: listQ5Count,
      questionResultList: selectedQ5Values,
      questionValue: valueQ5,
      surveyOnPressed: () {
        debugPrint('$selectedQ1Values');
        debugPrint('$selectedQ2Values');
        debugPrint('$selectedQ3Values');
        debugPrint('$selectedQ4Values');
        debugPrint('$selectedQ5Values');
      },
      onSurveyContentValueChange: (value) {
        valueQ5 = value;
      });
}
