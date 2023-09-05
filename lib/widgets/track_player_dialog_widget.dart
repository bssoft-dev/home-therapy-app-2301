import 'dart:convert';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/widgets/track_widget.dart';

List<String> ipv4Addresses = [];
late List<String> trackPlayList;
late List<bool> trackPlayIndex;
String? trackTitle;

Future<bool> asyncMethod() async {
  await getIpAddress();
  bool isDeviceConnected = await checkDeviceConnected();
  if (isDeviceConnected == true) {
    var response = await playList();
    if (response == 503) {
      return false;
    }
    trackPlayList = jsonDecode(utf8.decode(response.bodyBytes)).cast<String>();
    await initTrackTitle(trackPlayList);
  }
  trackPlayIndex = List<bool>.generate(
      trackPlayList.length, (int index) => false,
      growable: true);
  return isDeviceConnected;
}

Future<void> initTrackTitle(trackPlayList) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedTrackTitle = prefs.getString('selected_track');
  trackTitle = savedTrackTitle ?? trackPlayList[0].split('.wav')[0];
}

Future<void> getIpAddress() async {
  await NetworkInterface.list().then((interfaces) {
    for (var interface in interfaces) {
      for (var address in interface.addresses) {
        if (address.type == InternetAddressType.IPv4) {
          String ipAddress = address.address;
          int dotIndex = ipAddress.lastIndexOf('.');
          if (dotIndex != -1) {
            ipv4Addresses.add(ipAddress.substring(0, dotIndex));
          } else {
            ipv4Addresses.add(ipAddress);
          }
        }
      }
    }
    debugPrint('$ipv4Addresses');
  });
}

Future previewTrack(
    BuildContext context, String trackTitle, String actionText) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: ((context, StateSetter setDialog) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor.mainColor(),
                          ),
                          child: Lottie.asset('assets/lottie/track_list.json',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                              animate: true),
                        )),
                    Text(trackTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: trackPlayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Lottie.asset(
                                  'assets/lottie/sound_play.json',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  animate: trackPlayIndex[index]),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(trackPlayList[index]),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: playIconButton(
                                        Icons.play_arrow,
                                        Icons.pause_circle_outline,
                                        40,
                                        trackPlayIndex[index], () async {
                                      setDialog(() {
                                        trackPlayIndex[index] =
                                            !trackPlayIndex[index];
                                      });
                                      if (trackPlayIndex[index]) {
                                        await trackPlay(
                                            'ready', trackPlayList[index]);
                                      } else {
                                        await playStop();
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(actionText, style: const TextStyle(fontSize: 20)),
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

Future playTrack(
    {required BuildContext context,
    required String trackTitle,
    required String actionText,
    Future? emotionSurvey}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: ((context, StateSetter setDialog) {
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
          content: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor.mainColor(),
                          ),
                          child: Lottie.asset('assets/lottie/track_list.json',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                              animate: true),
                        )),
                    Text(trackTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: trackPlayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Lottie.asset(
                                  'assets/lottie/sound_play.json',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  animate: trackPlayIndex[index]),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(trackPlayList[index]),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: playIconButton(
                                        Icons.play_arrow,
                                        Icons.pause_circle_outline,
                                        40,
                                        trackPlayIndex[index], () async {
                                      setDialog(() {
                                        trackPlayIndex[index] =
                                            !trackPlayIndex[index];
                                      });
                                      if (trackPlayIndex[index]) {
                                        await trackPlay(
                                            'ready', trackPlayList[index]);
                                      } else {
                                        await playStop();
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(actionText, style: const TextStyle(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
                emotionSurvey;
              },
            ),
          ],
        );
      }));
    },
  );
}
