import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/survey_model.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? postAwakeList;
int postAwakeValue = 0;
List<int>? postAwakeValueList;

postAwakeServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<dynamic>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  List<dynamic>? comportPlotResult,
}) {
  loadAssetImages('awakener').then((value) {
    // print(value);
    postAwakeList = value;
    postAwakeValueList =
        List<int>.generate(postAwakeList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 각성가설문',
      surveyTitle: '질문 3/3',
      surveyContentTitle: '[각성가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: postAwakeList,
      surveyContentValueList: postAwakeValueList,
      surveyContentValue: postAwakeValue,
      onSurveyContentValueChange: (value) => postAwakeValue = value,
      surveyOnPressed: () async {
        httpPostRun(
                path: 'api/runs',
                data: SurveyResult(
                  sn: 'test',
                  username: 'test',
                  noise: noiseCheckResult,
                  preEmotion: preEmotionCheckResult,
                  preAwake: preAwakeCheckResult,
                  tracks: playTrackTitleReuslt,
                  comportPlot: comportPlotResult,
                  postEmotion: postEmotionCheckResult,
                  postAwake: postAwakeValue,
                ).toJson())
            .then((value) {
          if (value == 200) {
            Get.offAllNamed('/therapyDevice');
          }
          debugPrint('httpPostRun: $value');
        });
        // debugPrint('${SurveyResult(
        //   username: 'test',
        //   sn: 'test',
        //   noise: noiseCheckResult,
        //   preEmotion: preEmotionCheckResult,
        //   preAwake: preAwakeCheckResult,
        //   tracks: playTrackTitleReuslt,
        //   comportPlot: comportPlotResult,
        //   postEmotion: postEmotionCheckResult,
        //   postAwake: postAwakeValue,
        // ).toJson()}');
      },
    );
  });
}
