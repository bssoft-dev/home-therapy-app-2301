import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/widgets/survey_dialog/after_emtion_survey_dialog.dart';

Offset? marker;
List<double>? imageOffset;

imageEmotionServeyDialog({
  required BuildContext context,
  String? noiseCheckResult,
  int? emotionCheckResult,
  int? awakenerCheckResult,
  List<String>? playTrackTitleReuslt,
}) {
  return Get.dialog(barrierDismissible: false, name: '청취후감정설문',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 1/3',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('현재 본인과 비슷한 감정 상태 유형을 고르시오',
              style: TextStyle(fontSize: 15)),
          const SizedBox(height: 15),
          GestureDetector(
              onTapDown: (TapDownDetails details) {
                setDialog(() {
                  marker = details.localPosition;
                  imageOffset = [marker!.dx, marker!.dy];

                  print(imageOffset);
                });
              },
              child: Stack(
                children: [
                  Image.asset('assets/survey/image_emotion.png'),
                  if (marker != null)
                    Positioned(
                      left: marker!.dx - 20,
                      top: marker!.dy - 50,
                      child: Icon(Icons.where_to_vote,
                          size: 50, color: mainColor.mainColor()),
                    ),
                ],
              )),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('확인', style: TextStyle(fontSize: 20)),
          onPressed: () {
            Get.back();
            afterEmotionServeyDialog(
                context: context,
                noiseCheckResult: noiseCheckResult,
                emotionCheckResult: emotionCheckResult,
                awakenerCheckResult: awakenerCheckResult,
                playTrackTitleReuslt: playTrackTitleReuslt,
                imageOffsetResult: imageOffset);
          },
        ),
      ],
    );
  })));
}
