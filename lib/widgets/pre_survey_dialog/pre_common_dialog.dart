import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/model/survey_word_position_model.dart';
import 'package:home_therapy_app/widgets/pre_survey_dialog/survey_question_list.dart';
import 'package:home_therapy_app/widgets/range_dropdown_widget.dart';

Future<List<int>> fetchData() async {
  return List<int>.generate(101 - 0, (i) => i + 0);
}

preCommonSurveyDialog({
  required BuildContext context,
  required String dialogName,
  required String surveyTitle,
  required List<String> questionTitle,
  required int radioNumber,
  required int noteNumber,
  required int questionNumber,
  required int questionValue,
  required List<int> questionResultList,
  required VoidCallback surveyOnPressed,
  required ValueChanged<WordPositionSurvey> onSurveyMapValueChange,
  required ValueChanged<int> onSurveyContentValueChange,
  final String? surveyStageTitle,
  final String? prefixQuestionTitle,
}) {
  return Get.dialog(
      barrierDismissible: false, name: dialogName, useSafeArea: false,
      StatefulBuilder(builder: (context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      title: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          surveyStageTitle != null
              ? Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surveyStageTitle,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                  ],
                )
              : const SizedBox.shrink(),
          Text(
            surveyTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          // const SizedBox(height: 10),
          // Text(
          //   '※ ${note[noteNumber]}',
          //   style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          // )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                  // shrinkWrap: false,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: questionNumber,
                  itemBuilder: (BuildContext context, int questionIndex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        prefixQuestionTitle != null
                            ? RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text:
                                          '${questionIndex + 1}. $prefixQuestionTitle',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: questionTitle[questionIndex],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                '${questionIndex + 1}.${questionTitle[questionIndex]}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 17),
                              ),
                        const SizedBox(height: 10),
                        if (surveyTitle.contains('매우 동의한다'))
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('평가점수:'),
                                  const SizedBox(
                                    width: 14,
                                  ),
                                  FutureBuilder<List<int>>(
                                    future: fetchData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return RangeDropdownMenu(
                                          onSelected: (int? value) {
                                            print(value);
                                            setDialog(() {
                                              questionResultList[
                                                  questionIndex] = value as int;
                                              onSurveyMapValueChange(
                                                  WordPositionSurvey(
                                                      questionIndex, value));
                                              onSurveyContentValueChange(value);
                                            });
                                          },
                                          questionResultList: snapshot.data!,
                                          selectedValue: 50,
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("Error: ${snapshot.error}");
                                      }
                                      // 데이터를 기다리는 동안 보여줄 로딩 인디케이터를 반환합니다.
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal, // 가로 스크롤 사용
                            child: Row(
                              children:
                                  List.generate(radioNumber, (choiceIndex) {
                                return Column(
                                  children: [
                                    if (!surveyTitle.contains('성격 특성') &&
                                        !surveyTitle.contains('공간'))
                                      Text(ratingText[choiceIndex],
                                          style: const TextStyle(fontSize: 15)),
                                    if (surveyTitle.contains('성격 특성'))
                                      Text(tipiRatingText[choiceIndex],
                                          style: const TextStyle(fontSize: 15)),
                                    // if (surveyTitle
                                    //     .contains('공간')) // 사운드 스케이프 질문
                                    //   Text(wordPositionRatingText[choiceIndex],
                                    //       style: const TextStyle(fontSize: 15)),
                                    Radio(
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      value: choiceIndex,
                                      groupValue:
                                          questionResultList[questionIndex],
                                      onChanged: (value) {
                                        setDialog(() {
                                          questionResultList[questionIndex] =
                                              value as int;
                                          onSurveyMapValueChange(
                                              WordPositionSurvey(
                                                  questionIndex, value));
                                          onSurveyContentValueChange(value);
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10)
                                  ],
                                );
                              }),
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: surveyOnPressed,
          child: const Text('확인', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }));
}
