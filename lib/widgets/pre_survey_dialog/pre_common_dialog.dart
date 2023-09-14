import 'package:flutter/material.dart';
import 'package:get/get.dart';

preCommonSurveyDialog({
  required BuildContext context,
  required String dialogName,
  required String surveyTitle,
  required List<String> questionTitle,
  required int noteNumber,
  required List<String> note,
  required int questionNumber,
  required int questionValue,
  required List<int> questionResultList,
  required VoidCallback surveyOnPressed,
  required ValueChanged<int> onSurveyContentValueChange,
}) {
  return Get.dialog(
      barrierDismissible: false, name: dialogName, useSafeArea: false,
      StatefulBuilder(builder: (context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            surveyTitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '※ ${note[noteNumber]}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: questionNumber,
                  itemBuilder: (BuildContext context, int questionIndex) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${questionIndex + 1}.${questionTitle[questionIndex]}',
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(5, (choiceIndex) {
                            return Column(
                              children: [
                                Text('${choiceIndex + 1}',
                                    style: const TextStyle(fontSize: 10)),
                                Radio(
                                  value: choiceIndex,
                                  groupValue: questionResultList[questionIndex],
                                  onChanged: (value) {
                                    setDialog(() {
                                      questionResultList[questionIndex] =
                                          value as int;
                                      onSurveyContentValueChange(value);
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
                        )
                      ],
                    );
                  }),
            ],
          ),
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
