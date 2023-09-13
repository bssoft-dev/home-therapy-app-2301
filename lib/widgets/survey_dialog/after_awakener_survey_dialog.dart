import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/survey_model.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/common_survey.dart';

List<String>? afterAwakenerList;
int afterAwakenerValue = 0;
List<int>? afterAwakenerValueList;

afterAwakenerServeyDialog({
  required BuildContext context,
  String? noiseCheckResult,
  int? emotionCheckResult,
  int? awakenerCheckResult,
  List<String>? playTrackTitleReuslt,
  int? afterEmotionCheckResult,
  List<double>? imageOffsetResult,
}) {
  loadAssetImages('awakener').then((value) {
    // print(value);
    afterAwakenerList = value;
    afterAwakenerValueList =
        List<int>.generate(afterAwakenerList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 각성가설문',
      surveyTitle: '질문 3/3',
      surveyContentTitle: '[각성가]',
      surveyContent: '현재 본인과 비슷한 감정 상태 유형을 고르시오',
      surveyImageList: afterAwakenerList,
      surveyContentValueList: afterAwakenerValueList,
      surveyContentValue: afterAwakenerValue,
      surveyOnPressed: () {
        Get.back();
        SurveyResult(
          noise: noiseCheckResult,
          emotion: emotionCheckResult,
          awakener: awakenerCheckResult,
          trackList: playTrackTitleReuslt,
          image: imageOffsetResult,
          afEmotion: afterEmotionCheckResult,
          afAwakener: afterAwakenerValue,
        ).toJson();
        print(SurveyResult(
          noise: noiseCheckResult,
          emotion: emotionCheckResult,
          awakener: awakenerCheckResult,
          trackList: playTrackTitleReuslt,
          image: imageOffsetResult,
          afEmotion: afterEmotionCheckResult,
          afAwakener: afterAwakenerValue,
        ).toJson());
      },
    );
  });
}
