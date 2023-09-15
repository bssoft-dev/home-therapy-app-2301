import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/pre_survey_model.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
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
      surveyTitle: '스트레스 평가',
      questionTitle: pssQ,
      note: note,
      noteNumber: 3,
      radioNumber: 5,
      questionNumber: pssQ.length,
      questionResultList: selectedPValues,
      questionValue: valueP,
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
      surveyTitle: '개인 성격 특성 검사',
      questionTitle: tipiQ,
      note: note,
      noteNumber: 4,
      radioNumber: 7,
      questionNumber: tipiQ.length,
      questionResultList: selectedTValues,
      questionValue: valueT,
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
