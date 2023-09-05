import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/widgets/track_player_dialog_widget.dart';
import 'package:home_therapy_app/widgets/volume_controller_widget.dart';
import 'package:lottie/lottie.dart';

String emotionValueInit = '행복';
Future<bool>? asyncMethodFuture;
double currentVolume = 50;

emotionServeyDialog({
  required BuildContext context,
  AnimationController? lottieController,
  bool? isPlaying,
}) {
  asyncMethodFuture = asyncMethod();
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
          content: emotionList(setDialog: setDialog),
          actions: [
            TextButton(
              child: const Text('확인', style: TextStyle(fontSize: 15)),
              onPressed: () {
                playTrack(
                    context: context,
                    trackTitle: '음원목록',
                    actionText: '종료',
                    volumeSlider: const VolumeController(),
                    emotionSurvey: showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: ((context, StateSetter setDialog) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            actionsPadding: const EdgeInsets.only(bottom: 10),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            title: const Text('현재 감정 상태',
                                style: TextStyle(fontSize: 20)),
                            content: emotionList(setDialog: setDialog),
                            actions: [
                              TextButton(
                                child: const Text('확인',
                                    style: TextStyle(fontSize: 15)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.popAndPushNamed(
                                      context, '/therapyDevice');
                                },
                              ),
                            ],
                          );
                        }));
                      },
                    ));
              },
            ),
          ],
        );
      }));
    },
  );
}

Widget emotionList({
  required StateSetter setDialog,
}) {
  return Row(
    children: [
      emotionCheck(
          emotion: 'love_emotion', emotionValue: '행복', setDialog: setDialog),
      emotionCheck(
          emotion: 'smile_emotion', emotionValue: '웃음', setDialog: setDialog),
      emotionCheck(
          emotion: 'normal_emotion', emotionValue: '보통', setDialog: setDialog),
      emotionCheck(
          emotion: 'sad_emotion', emotionValue: '슬픔', setDialog: setDialog),
      emotionCheck(
          emotion: 'angry_emotion', emotionValue: '화남', setDialog: setDialog),
    ],
  );
}

Widget emotionCheck(
    {required String emotion,
    required String emotionValue,
    required StateSetter setDialog}) {
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
