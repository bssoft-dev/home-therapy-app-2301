import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

String emotionValueInit = '행복';

Future emotionServeyDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: ((context, StateSetter setDialog) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 10),
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          title: const Text('현재 감정 상태', style: TextStyle(fontSize: 20)),
          content: Row(
            children: [
              emotionCheck('love_emotion', '행복', setDialog),
              emotionCheck('smile_emotion', '웃음', setDialog),
              emotionCheck('normal_emotion', '보통', setDialog),
              emotionCheck('sad_emotion', '슬픔', setDialog),
              emotionCheck('angry_emotion', '화남', setDialog),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('확인', style: TextStyle(fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }));
    },
  );
}

Widget emotionCheck(
    String emotion, String emotionValue, StateSetter setDialog) {
  return Expanded(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          'assets/lottie/$emotion.json',
          width: 40,
          height: 40,
          fit: BoxFit.fill,
        ),
        Radio(
            value: emotionValue,
            groupValue: emotionValueInit,
            onChanged: (value) {
              debugPrint(value);
              setDialog(() {
                emotionValueInit = value.toString();
              });
            }),
      ],
    ),
  );
}
