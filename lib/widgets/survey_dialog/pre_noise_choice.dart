import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_noise_choice_score.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_survey_question_list.dart';

List<int>? noiseTypeValueList;
List<int> noiseTypeValue = [];
List<bool> noiseTypeCheckbox = List<bool>.filled(noiseType.length, false);

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
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                '발생한 소음의 종류를 선택해주세요',
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '※ ',
                    ),
                    TextSpan(
                      text: '소음이 발생하지 않았다면',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        height: 1,
                      ),
                    ),
                    TextSpan(
                      text: ' "다음"',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: '을 선택해 주세요',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              // const Text('발생한 소음의 종류를 선택해주세요', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 15),
              SizedBox(
                child: Column(
                  children:
                      List.generate(noiseType.length, (questionIndexntext) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: noiseTypeCheckbox[questionIndexntext],
                              onChanged: (value) {
                                setDialog(
                                  () {
                                    noiseTypeCheckbox[questionIndexntext] =
                                        value!;
                                    if (value) {
                                      noiseTypeValue.add(questionIndexntext);
                                    } else {
                                      noiseTypeValue.remove(questionIndexntext);
                                    }
                                  },
                                );
                              },
                            ),
                            Expanded(
                              child: Text(
                                noiseType[questionIndexntext],
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              print(noiseTypeValue);
              Get.back();
              await preNoiseChoiceScoreDialog(
                  context: context,
                  noiseCheckResult: noiseCheckResult,
                  noiseTypeValue: noiseTypeValue);
              debugPrint(('noiseType:$noiseTypeValue'));
              debugPrint(('noiseDialog:$noiseCheckResult'));
              noiseTypeCheckbox = List<bool>.filled(noiseType.length, false);
              noiseTypeValue = [];
            },
            child: const Text(
              '다음',
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  })));
}
