import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/survey_model.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
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
  int? noiseTypeValue,
  int? noiseTypeScoreValue,
  List? comportPlotResult,
  int? comportPlotRatingResult, 
  String? comportPlotTitleResult,
}) {
  loadAssetSVGs('awakener').then((value) {
    // print(value);
    postAwakeList = value;
    postAwakeValueList =
        List<int>.generate(postAwakeList!.length, (index) => index);

    return commonSurveyDialog(
      context: context,
      dialogName: '청취후 각성가설문',
      surveyTitle: '질문 3/3',
      surveyContentTitle: '[각성가]',
      surveyContent: '현재 본인과 가장 알맞는 감정 상태를 고르시오',
      surveyImageList: postAwakeList,
      surveyContentValueList: postAwakeValueList,
      surveyContentValue: postAwakeValue,
      onSurveyContentValueChange: (value) => postAwakeValue = value,
      surveyOnPressed: () async {
        Get.dialog(
            barrierDismissible: false,
            name: '최종 종료 질문',
            AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.only(bottom: 10),
              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              title: const Text(
                '설문 종료',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text('만약 듣고 있는 음원이 있으면 종료가 됩니다.\n종료하시겠습니까?',
                        style: TextStyle(fontSize: 17)),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final sn = await getStoredValue('sn');
                              final username = await getStoredValue('username');
                              httpPostServer(
                                      path: 'api/runs',
                                      data: SurveyResult(
                                        sn: sn,
                                        username: username,
                                        noise: noiseCheckResult,
                                        noiseType: [noiseTypeValue,noiseTypeScoreValue],
                                        preEmotion: preEmotionCheckResult,
                                        preAwake: preAwakeCheckResult,
                                        tracks: playTrackTitleReuslt,
                                        comportPlotRating: comportPlotResult,
                                        postEmotion: postEmotionCheckResult,
                                        postAwake: postAwakeValue,
                                        version:2
                                      ).toJson())
                                  .then((value) async {
                                if (value == 200) {
                                  postAwakeValue = 0;
                                  await Get.offAllNamed('/therapyDevice');
                                }
                                debugPrint('httpPostServer: $value');
                              });
                            },
                            child: const Text('예',
                                style: TextStyle(fontSize: 20))),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text('아니오',
                                style: TextStyle(fontSize: 20))),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ));
      },
    );
  });
}
