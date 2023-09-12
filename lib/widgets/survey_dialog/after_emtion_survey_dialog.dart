import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/assets_list.dart';
import 'package:home_therapy_app/widgets/survey_dialog/after_awakener_survey_dialog.dart';

bool isYesCheck = false;
bool isNoCheck = false;
String? noiseCheckResult;

List<String>? emotionList;

afterEmotionServeyDialog({
  required BuildContext context,
}) {
  loadAssetImages('emotion').then((value) {
    // print(value);
    emotionList = value;
  });
  double emotionHeight = MediaQuery.of(context).size.height * 0.15;

  return Get.dialog(barrierDismissible: false, name: '정서가설문',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 2/3',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('[정서가]', style: TextStyle(fontSize: 15)),
          const Text('현재 본인과 비슷한 감정 상태 유형을 고르시오',
              style: TextStyle(fontSize: 15)),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: GridView.builder(
                itemCount: emotionList!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: emotionHeight,
                ),
                itemBuilder: ((BuildContext context, index) {
                  return Column(
                    children: [
                      Image.asset(emotionList![index]),
                      Radio(
                        value: index,
                        groupValue: 0,
                        onChanged: (value) {
                          setDialog(() {
                            print(value);
                          });
                        },
                      ),
                    ],
                  );
                })),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('확인', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Get.back();
            afterAwakenerServeyDialog(context: context);
          },
        ),
      ],
    );
  })));
}
