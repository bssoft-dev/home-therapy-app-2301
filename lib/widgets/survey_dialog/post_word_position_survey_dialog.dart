import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/survey_model.dart';
import 'package:home_therapy_app/model/version_model.dart';
import 'package:home_therapy_app/utils/http_request_api.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:home_therapy_app/utils/track_play_api.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/pre_common_dialog.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';

int wordPositionTitleValue = 0;
int wordPositionRatingValue = 0;
List comportValueResult = List.generate(wordPositionText.length, (index) => 50);
List<int> selectedValues =
    List.generate(wordPositionText.length, (index) => 50);
VersionCurrent currentVersion = VersionCurrent();

postWordPositionServeyDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<Map<String, dynamic>>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  List<int>? noiseTypeValue,
  int? noiseTypeScoreValue,
  List? wordPositionResult,
  int? wordPositionRatingResult,
  String? wordPositionTitleResult,
  int? postAwakeValue,
  int? postNoise,
}) {
  return preCommonSurveyDialog(
    context: context,
    surveyStageTitle: '질문 4/4',
    dialogName: '소리와 공간에 맞는 단어 위치 선택 설문',
    surveyTitle:
        '다음은 현재 공간에서 들리는 음환경을 평가하는 것입니다. 아래의 항목에 대해 동의하는 정도를 0 (전혀 동의하지 않는다)부터 100 (매우 동의한다)까지 평가하여 주십시오.',
    questionTitle: wordPositionText,
    noteNumber: 0,
    radioNumber: 7,
    questionNumber: wordPositionText.length,
    questionResultList: selectedValues,
    questionValue: wordPositionRatingValue,
    prefixQuestionTitle: '현재 거주공간에서 들리는 음환경이 ',
    surveyOnPressed: () async {
      return Get.dialog(
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
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () async {
                            if (playTrackTitleReuslt?.last['time'] is! int) {
                              playStop();
                              endTime = DateTime.now();
                              await calculateElapsedTime(
                                      playTrackTitleReuslt?.last['time']!,
                                      endTime!)
                                  .then((playingTime) {
                                playTrackTitleReuslt?.last = ({
                                  "name": playTrackTitleReuslt.last['name'],
                                  "time": playingTime,
                                });
                              });
                            }
                            final sn = await getStoredValue('sn');
                            final username = await getStoredValue('username');
                            httpPostServer(
                              path: 'api/runs',
                              data: SurveyResult(
                                      sn: sn,
                                      username: username,
                                      noise: noiseCheckResult,
                                      noiseTypeValue: noiseTypeValue,
                                      noiseScore: noiseTypeScoreValue,
                                      preEmotion: preEmotionCheckResult,
                                      preAwake: preAwakeCheckResult,
                                      tracks: playTrackTitleReuslt,
                                      wordPositionRating: comportValueResult,
                                      postEmotion: postEmotionCheckResult,
                                      postAwake: postAwakeValue,
                                      postNoise: postNoise,
                                      version: currentVersion.versionValue)
                                  .toJson(),
                            ).then((value) async {
                              if (value == 200) {
                                postAwakeValue = 0;
                                await Get.offAllNamed('/therapyDevice');
                              }
                              debugPrint('httpPostServer: $value');
                              selectedValues = List.generate(
                                  wordPositionText.length, (index) => 50);
                              comportValueResult = List.generate(
                                  wordPositionText.length, (index) => 50);
                            });
                          },
                          child:
                              const Text('예', style: TextStyle(fontSize: 20))),
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
    onSurveyContentValueChange: (value) => debugPrint('사용하지않음'),
    onSurveyMapValueChange: (value) {
      wordPositionTitleValue = value.titleValue;
      wordPositionRatingValue = value.ratingValue;
      comportValueResult[value.titleValue] = value.ratingValue;
    },
  );
}
