import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_noise_choice_score.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_survey_question_list.dart';

List<int>? noiseTypeValueList;
int noiseTypeValue = 0;

preNoiseChoiceDialog({
  required BuildContext context,
  bool? noiseCheckResult,
}) {
  noiseTypeValueList = List<int>.generate(noiseType.length, (index) => index);
  return Get.dialog(barrierDismissible: false, name: '소음종류선택',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 2/5',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text('발생한 소음의 종류를 선택해주세요', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                  itemCount: noiseType.length,
                  itemBuilder: (BuildContext context, int questionIndexntext) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(noiseType[questionIndexntext]),
                            Radio(
                                value: noiseTypeValueList![questionIndexntext],
                                groupValue: noiseTypeValue,
                                onChanged: (value) {
                                  setDialog(() {
                                    noiseTypeValue = value as int;
                                    noiseTypeValueList![questionIndexntext] =
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
            onPressed: () async {
              Get.back();
              await preNoiseChoiceScoreDialog(
                  context: context,
                  noiseCheckResult: noiseCheckResult,
                  noiseTypeValue: noiseType[noiseTypeValue]);
              debugPrint(('noiseDialog:$noiseCheckResult'));
              debugPrint(('noiseType:${noiseType[noiseTypeValue]}'));
              noiseTypeValue = 0;
            },
            child: const Text(
              '다음',
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  })));
}
