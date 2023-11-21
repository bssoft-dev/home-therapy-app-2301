import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_emotion_survey_dialog.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_noise_choice.dart';

bool isYesCheck = false;
bool isNoCheck = false;
bool? noiseCheckResult;
noiseServeyDialog({
  required BuildContext context,
}) {
  return Get.dialog(barrierDismissible: false, name: '소음여부설문',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 10),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      title: const Text(
        '질문 1/5',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('현재 소음이 발생하였습니까?', style: TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                changeIconButton(
                  icon: Icons.check_circle_outline_rounded,
                  size: 60,
                  isChange: isYesCheck,
                  iconColor: const Color(0xff5a5a5a),
                  alternateIconColor: mainColor.mainColor(),
                  onPressed: () {
                    setDialog(() {
                      isYesCheck = !isYesCheck;
                      if (isYesCheck) {
                        isNoCheck = false;
                      }
                      noiseCheckResult = true;
                    });
                  },
                ),
                changeIconButton(
                  icon: Icons.highlight_off_rounded,
                  size: 60,
                  isChange: isNoCheck,
                  iconColor: const Color(0xff5a5a5a),
                  alternateIconColor: mainColor.mainColor(),
                  onPressed: () {
                    setDialog(() {
                      isNoCheck = !isNoCheck;
                      if (isNoCheck) {
                        isYesCheck = false;
                      }
                      noiseCheckResult = false;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            '확인',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onPressed: () async {
            if (isNoCheck || isYesCheck) {
              Get.back();
              setDialog(() {
                isYesCheck = false;
                isNoCheck = false;
              });
              await preNoiseChoiceDialog(
                  context: context, noiseCheckResult: noiseCheckResult);
              debugPrint(('noiseDialog:$noiseCheckResult'));
            } else {
              failSnackBar('오류', '소음여부를 선택해주세요.');
            }
          },
        ),
      ],
    );
  })));
}
