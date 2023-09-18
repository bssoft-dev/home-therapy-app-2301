import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/widgets/track_mixing_slider.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/utils/track_play.dart';

List<String> ipv4Addresses = [];
late List<String> trackPlayList;
late List<bool> trackPlayIndex;
String? trackTitle;
String firstMixingTrack = '';
String secondMixingTrack = '';
List<Map<String, dynamic>> playTrackTitleTime = [];
DateTime? startTime;
DateTime? endTime;
List<int> playingTime = [];

Future<bool> asyncTrackPlayListMethod() async {
  await getIpAddress();
  bool isDeviceConnected = await checkDeviceConnected();
  if (isDeviceConnected == true) {
    var response = await playList();
    trackPlayList = jsonDecode(utf8.decode(response.bodyBytes)).cast<String>();
    await initTrackTitle(trackPlayList);
    trackPlayIndex = List<bool>.generate(
        trackPlayList.length, (int index) => false,
        growable: true);
    if (response == 503) {
      return false;
    }
  }
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

Future playTrack({
  required BuildContext context,
  required String trackTitle,
  required String actionText,
  required Future Function(List<dynamic> playTrackTitle) tracks,
  Widget? volumeSlider,
}) {
  return Get.dialog(barrierDismissible: false, name: '음원재생',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor.mainColor(),
                    ),
                    child: Lottie.asset('assets/lottie/track_list.json',
                        width: 40, height: 40, fit: BoxFit.fill, animate: true),
                  ),
                  const SizedBox(width: 10),
                  Text(trackTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
                child: trackList(setDialog: setDialog, context: context)),
          ],
        ),
      ),
      actions: <Widget>[
        volumeSlider ?? const SizedBox(height: 0),
        TextButton(
          child: Text(actionText, style: const TextStyle(fontSize: 20)),
          onPressed: () async {
            if (playTrackTitleTime.isNotEmpty) {
              await tracks(playTrackTitleTime);
              // print(playTrackTitleTime);
              setDialog(() {
                playTrackTitleTime = [];
                Get.back();
              });
            } else {
              failSnackBar('오류', '음원을 선택해 재생시켜주세요.');
            }
          },
        ),
      ],
    );
  })));
}

Future prePlayTrack({
  required BuildContext context,
  required String trackTitle,
  required String actionText,
  Widget? volumeSlider,
}) {
  return Get.dialog(barrierDismissible: false, name: '음원재생',
      StatefulBuilder(builder: ((context, StateSetter setDialog) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor.mainColor(),
                    ),
                    child: Lottie.asset('assets/lottie/track_list.json',
                        width: 40, height: 40, fit: BoxFit.fill, animate: true),
                  ),
                  const SizedBox(width: 10),
                  Text(trackTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
                child: trackList(setDialog: setDialog, context: context)),
          ],
        ),
      ),
      actions: <Widget>[
        volumeSlider ?? const SizedBox(height: 0),
        TextButton(
          child: Text(actionText, style: const TextStyle(fontSize: 20)),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  })));
}

Widget trackList({
  required StateSetter setDialog,
  required BuildContext context,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.5,
    child: ListView.builder(
        shrinkWrap: true,
        itemCount: trackPlayList.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Lottie.asset('assets/lottie/sound_play.json',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    animate: trackPlayIndex[index]),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          trackPlayIndex[index] = !trackPlayIndex[index];
                        });
                        if (trackPlayIndex[index]) {
                          await trackPlay('ready', trackPlayList[index]);
                          startTime = DateTime.now();
                        } else {
                          await playStop();
                          endTime = DateTime.now();
                          await calculateElapsedTime(startTime!, endTime!)
                              .then((playingTime) {
                            playTrackTitleTime.add({
                              "name": trackPlayList[index],
                              "time": playingTime,
                            });
                          });
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
  );
}

Future<int> calculateElapsedTime(DateTime startTime, DateTime endTime) async {
  Duration elapsedDuration = endTime.difference(startTime);
  return elapsedDuration.inSeconds;
}

Widget mixTrackList({required List containerColors}) {
  return StatefulBuilder(builder: (context, StateSetter setState) {
    return Stack(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trackPlayList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        containerColors[index] = !containerColors[index];
                        debugPrint('${containerColors[index]}');
                        int bottmSheetCount = containerColors
                            .where((element) => element == true)
                            .length;
                        if (bottmSheetCount >= 2) {
                          List<String> selectedTracks = [];
                          for (int i = 0; i < trackPlayList.length; i++) {
                            if (containerColors[i]) {
                              selectedTracks.add(trackPlayList[i]);
                            }
                          }
                          // if (selectedTracks.length >= 2) {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  child: TrackMixingSlider(
                                      trackSelectOne: selectedTracks[0],
                                      trackSelectTwo: selectedTracks[1]),
                                );
                              });
                          // }
                        }
                      });
                    },
                    child: Container(
                      color: containerColors[index]
                          ? mainColor.mainColor().withOpacity(0.1)
                          : Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              trackPlayList[index],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                  containerColors[index]
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  color: mainColor.mainColor()),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: playIconButton(
                                    Icons.play_arrow,
                                    Icons.pause_circle_outline,
                                    40,
                                    trackPlayIndex[index], () async {
                                  setState(() {
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 0,
                  ),
                ],
              );
            }),
      ],
    );
  });
}
