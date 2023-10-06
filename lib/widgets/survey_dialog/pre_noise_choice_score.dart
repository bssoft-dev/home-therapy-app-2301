import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_emotion_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_survey_question_list.dart';

List<int>? noiseScoreValueList;
int noiseScoreValue = 0;

preNoiseChoiceScoreDialog({
  required BuildContext context,
  bool? noiseCheckResult,
  String? noiseTypeValue,
}) {
  noiseScoreValueList =
      List<int>.generate(noiseTypeScore.length, (index) => index);
  return Get.dialog(barrierDismissible: false, name: '소음신경쓰임정도',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 3/5',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text('선택한 소음의 신경쓰임 정도를 선택해주세요',
                style: TextStyle(fontSize: 17)),
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
                            Text(noiseType[questionIndexntext]),
                            Radio(
                                value: noiseScoreValueList![questionIndexntext],
                                groupValue: noiseScoreValue,
                                onChanged: (value) {
                                  setDialog(() {
                                    noiseScoreValue = value as int;
                                    noiseScoreValueList![questionIndexntext] =
                                        value;
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
            onPressed: () {
              Get.back();
              preEmotionServeyDialog(
                  context: context,
                  noiseCheckResult: noiseCheckResult,
                  noiseTypeValue: noiseTypeValue,
                  noiseTypeScoreValue: noiseScoreValue + 1);
              debugPrint(('noiseDialog:$noiseCheckResult'));
              debugPrint(('noiseType:$noiseTypeValue'));
              debugPrint(('noiseTypeScore:${(noiseScoreValue + 1)}'));
            },
            child: const Text(
              '다음',
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  })));
}
