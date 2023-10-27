import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/http_request_api.dart';
import 'package:home_therapy_app/widgets/survey_dialog/post_awakener_survey_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

void checkVersion() async {
  final serverVersion = await httpGetServer(path: '/api/survey/recent-ver');
  if (currentVersion.versionValue == serverVersion) {
    Get.dialog(
        barrierDismissible: false,
        name: 'version 업데이트 알림',
        WillPopScope(
            // 여기에 동작을 추가해주면 된다.
            onWillPop: () async => false,
            child: (AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              actionsPadding: const EdgeInsets.only(bottom: 10),
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text('app 업그레이드가 필요합니다.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('업그레이드 버튼을 눌러서\n app을 업그레이드 해주세요.',
                      style: TextStyle(fontSize: 15)),
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://play.google.com/store/apps/details?id=com.bssoft.home_therapy_app');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: const Text('업데이트', style: TextStyle(fontSize: 20)),
                    )
                  ],
                )
              ],
            ))));
  }
}
