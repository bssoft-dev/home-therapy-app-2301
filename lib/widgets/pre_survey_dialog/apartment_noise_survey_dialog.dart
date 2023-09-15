import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
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
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        print(sn);
        print(username);
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyA1': selectedA1Values}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyA1', 'yes');
            Get.back();
            apartmentNoiseServeyDialogQ2(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueA1 = value;
      });
}

apartmentNoiseServeyDialogQ2({
  required BuildContext context,
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
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyA2': selectedA2Values}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyA2', 'yes');
            Get.back();
            apartmentNoiseServeyDialogQ3(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueA2 = value;
      });
}

apartmentNoiseServeyDialogQ3({required BuildContext context}) {
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
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyA3': selectedA3Values}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyA3', 'yes');
            Get.back();
            apartmentNoiseServeyDialogQ4(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueA3 = value;
      });
}

apartmentNoiseServeyDialogQ4({required BuildContext context}) {
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
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyA4': selectedA4Values}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyA4', 'yes');
            Get.back();
            apartmentNoiseServeyDialogQ5(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueA4 = value;
      });
}

apartmentNoiseServeyDialogQ5({required BuildContext context}) {
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
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyA5': selectedA4Values}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyA5', 'yes');
            Get.back();
            pssServeyDialogQ(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueA5 = value;
      });
}
