import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pss_tipi_survey_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';

int valueA1 = 0;
int valueA2 = 0;
int valueA3 = 0;
int valueA4 = 0;
int valueA5 = 0;

List<int> selectedA1Values =
    List.generate(apartmentNoiseQ1_2.length, (index) => 0);
List<int> selectedA2Values =
    List.generate(apartmentNoiseQ1_2.length, (index) => 0);
List<int> selectedA3Values =
    List.generate(apartmentNoiseQ3_4.length, (index) => 0);
List<int> selectedA4Values =
    List.generate(apartmentNoiseQ3_4.length, (index) => 0);
List<int> selectedA5Values =
    List.generate(apartmentNoiseQ5.length, (index) => 0);

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
      radioNumber: 5,
      questionNumber: apartmentNoiseQ1_2.length,
      questionResultList: selectedA1Values,
      questionValue: valueA1,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ2(
            context: context, selectedQ1Values: selectedA1Values);
      },
      onSurveyContentValueChange: (value) {
        valueA1 = value;
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
      radioNumber: 5,
      questionNumber: apartmentNoiseQ1_2.length,
      questionResultList: selectedA2Values,
      questionValue: valueA2,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ3(
            context: context,
            selectedA1Values: selectedA1Values,
            selectedA2Values: selectedA2Values);
      },
      onSurveyContentValueChange: (value) {
        valueA2 = value;
      });
}

apartmentNoiseServeyDialogQ3({
  required BuildContext context,
  required List<int> selectedA1Values,
  required List<int> selectedA2Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도3',
      surveyTitle: '3. 현재 거주 중인 곳에서 다음의 각 소리가 얼마나 자주 들리는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ3_4,
      note: note,
      noteNumber: 0,
      radioNumber: 5,
      questionNumber: apartmentNoiseQ3_4.length,
      questionResultList: selectedA3Values,
      questionValue: valueA3,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ4(
            context: context,
            selectedA1Values: selectedA1Values,
            selectedA2Values: selectedA2Values,
            selectedA3Values: selectedA3Values);
      },
      onSurveyContentValueChange: (value) {
        valueA3 = value;
      });
}

apartmentNoiseServeyDialogQ4({
  required BuildContext context,
  required List<int> selectedA1Values,
  required List<int> selectedA2Values,
  required List<int> selectedA3Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도4',
      surveyTitle: '4. 현재 거주 중인 곳에서 다음의 각 소리가 얼마나 신경쓰이는지 평가해주십시오.',
      questionTitle: apartmentNoiseQ3_4,
      note: note,
      noteNumber: 1,
      radioNumber: 5,
      questionNumber: apartmentNoiseQ3_4.length,
      questionResultList: selectedA4Values,
      questionValue: valueA4,
      surveyOnPressed: () {
        Get.back();
        apartmentNoiseServeyDialogQ5(
            context: context,
            selectedA1Values: selectedA1Values,
            selectedA2Values: selectedA2Values,
            selectedA3Values: selectedA3Values,
            selectedA4Values: selectedA4Values);
      },
      onSurveyContentValueChange: (value) {
        valueA4 = value;
      });
}

apartmentNoiseServeyDialogQ5({
  required BuildContext context,
  required List<int> selectedA1Values,
  required List<int> selectedA2Values,
  required List<int> selectedA3Values,
  required List<int> selectedA4Values,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '거주지 소음 및 소음 민감도5',
      surveyTitle: '5. 소음민감도.',
      questionTitle: apartmentNoiseQ5,
      note: note,
      noteNumber: 2,
      radioNumber: 5,
      questionNumber: apartmentNoiseQ5.length,
      questionResultList: selectedA5Values,
      questionValue: valueA5,
      surveyOnPressed: () {
        Get.back();
        pssServeyDialogQ(
            context: context,
            selectedA1Values: selectedA1Values,
            selectedA2Values: selectedA2Values,
            selectedA3Values: selectedA3Values,
            selectedA4Values: selectedA4Values,
            selectedA5Values: selectedA5Values);
      },
      onSurveyContentValueChange: (value) {
        valueA5 = value;
      });
}
