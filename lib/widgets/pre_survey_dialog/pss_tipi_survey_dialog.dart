import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/http_request_api.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';

int valueP = 0;
int valueT = 0;
List<int> selectedPValues = List.generate(pssQ.length, (index) => 0);
List<int> selectedTValues = List.generate(tipiQ.length, (index) => 0);

pssServeyDialogQ({
  required BuildContext context,
}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '스트레스 평가-PSS(perceived stress scale)',
      surveyTitle:
          '6. 다음은 본인의 스트레스를 측정하기 위한 것입니다.\n지난 한달 동안, 아래와 같은 일이 얼마나 자주 있었는지 또는\n동의하는 정도를 평가해 주십시오.',
      questionTitle: pssQ,
      noteNumber: 3,
      radioNumber: 5,
      questionNumber: pssQ.length,
      questionResultList: selectedPValues,
      questionValue: valueP,
      onSurveyMapValueChange: (value) {},
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyP': selectedPValues}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyP', 'yes');
            Get.back();
            tipiServeyDialogQ(context: context);
          } else {
            failSnackBar('오류', '설문 저장에 실패했습니다. 다시 시도해주세요');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueP = value;
      });
}

tipiServeyDialogQ({required BuildContext context}) {
  return preCommonSurveyDialog(
      context: context,
      dialogName: '개인 성격 특성 검사-TIPI(Ten-Item Personality Inventory)',
      surveyTitle:
          '7. 다음은 본인의 성격 특성을 측정하기 위한 것입니다.\n아래의 각 항목에 대해 동의하는 정도를 평가해 주십시오.',
      questionTitle: tipiQ,
      noteNumber: 4,
      radioNumber: 7,
      questionNumber: tipiQ.length,
      questionResultList: selectedTValues,
      questionValue: valueT,
      onSurveyMapValueChange: (value) {},
      surveyOnPressed: () async {
        final sn = await getStoredValue('sn');
        final username = await getStoredValue('username');
        httpPostServer(
            path: 'api/users/$sn/$username',
            data: {'surveyT': selectedTValues}).then((value) {
          if (value == 200) {
            //한번만 호출되도록 하는 캐시 저장코드
            saveStoredValue('surveyT', 'yes');
            Get.back();

            // removeStoredValue('sn');
            // removeStoredValue('username');
            // removeStoredValue('surveyA1');
            // removeStoredValue('surveyA2');
            // removeStoredValue('surveyA3');
            // removeStoredValue('surveyA4');
            // removeStoredValue('surveyA5');
            // removeStoredValue('surveyP');
            // removeStoredValue('surveyT');
          }
        });
      },
      onSurveyContentValueChange: (value) {
        valueT = value;
      });
}
