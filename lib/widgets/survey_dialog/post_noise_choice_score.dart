import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_emtion_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_survey_question_list.dart';

List<int>? postNoiseScoreValueList;
int postNoiseScoreValue = 0;

postNoiseChoiceScoreDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  int? preEmotionCheckResult,
  int? preAwakeCheckResult,
  List<Map<String, dynamic>>? playTrackTitleReuslt,
  int? postEmotionCheckResult,
  int? noiseTypeValue,
  int? noiseTypeScoreValue,
  int? postNoise,
}) {
  postNoiseScoreValueList =
      List<int>.generate(noiseTypeScore.length, (index) => index);
  return Get.dialog(barrierDismissible: false, name: '소음신경쓰임정도',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 1/4',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              '소리를 듣고 난 후 소음에 대해 신경쓰이는 정도를 평가해 주십시오.',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                  itemCount: noiseTypeScore.length,
                  itemBuilder: (BuildContext context, int questionIndexntext) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(noiseTypeScore[questionIndexntext]),
                            Radio(
                                value: postNoiseScoreValueList![
                                    questionIndexntext],
                                groupValue: postNoiseScoreValue,
                                onChanged: (value) {
                                  setDialog(() {
                                    postNoiseScoreValue = value as int;
                                    postNoiseScoreValueList![
                                        questionIndexntext] = value;
                                  });
                                })
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Get.back();
            debugPrint(('noiseDialog:$noiseCheckResult'));
            debugPrint(('noiseType:$noiseTypeValue'));
            debugPrint(('noiseTypeScore:$noiseTypeScoreValue'));
            debugPrint(('PreemotionDialog:$preEmotionCheckResult'));
            debugPrint(('PreawakeDialog:$preAwakeCheckResult'));
            debugPrint(('tracks:$playTrackTitleReuslt'));
            debugPrint(('PostemotionDialog:$postEmotionValue'));
            debugPrint(('postNoise:${(postNoiseScoreValue)}'));
            await postEmotionServeyDialog(
              context: context,
              noiseCheckResult: noiseCheckResult,
              noiseTypeValue: noiseTypeValue,
              noiseTypeScoreValue: noiseTypeScoreValue,
              preEmotionCheckResult: preEmotionCheckResult,
              preAwakeCheckResult: preAwakeCheckResult,
              playTrackTitleReuslt: playTrackTitleReuslt,
              postNoise: postNoiseScoreValue,
            );
            postNoiseScoreValue = 0;
          },
          child: const Text(
            '다음',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  })));
}
