import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:home_therapy_app/widgets/track_widget.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/widgets/main_color_widget.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/device_info_dialog_widget.dart';
import 'package:home_therapy_app/widgets/device_scann_dialog_widget.dart';

class TrackPlayer extends StatefulWidget {
  const TrackPlayer({super.key});

  @override
  State<TrackPlayer> createState() => _TrackPlayerState();
}

class _TrackPlayerState extends State<TrackPlayer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  List<String> ipv4Addresses = [];
  late List<String> trackPlayList;
  String? trackTitle;
  String? trackAuthor;
  bool isPlaying = false;
  bool? deviceConnected;
  int? currentVolume;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _asyncMethod() async {
    await getIpAddress();
    bool isDeviceConnected = await checkDeviceConnected();
    if (isDeviceConnected == true) {
      var response = await playList();
      if (response == 503) {
        return false;
      }
      trackPlayList =
          jsonDecode(utf8.decode(response.bodyBytes)).cast<String>();
      await initTrackTitle(trackPlayList);
    }
    return isDeviceConnected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add_to_queue_outlined,
          activeIcon: Icons.close,
          visible: true,
          childMargin: const EdgeInsets.all(15),
          children: [
            SpeedDialChild(
              backgroundColor: mainColor.mainColor(),
              labelBackgroundColor: mainColor.mainColor(),
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.transparent)),
              child: const Icon(Icons.zoom_in_outlined),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return DeviceScannDialog(ipv4Addresses);
                  },
                );
              },
              label: '기기 검색',
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            SpeedDialChild(
              backgroundColor: mainColor.mainColor(),
              labelBackgroundColor: mainColor.mainColor(),
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.transparent)),
              child: const Icon(Icons.app_settings_alt_outlined),
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const DeviceInfoDialog();
                  },
                );
              },
              label: '기기 정보',
              labelStyle: const TextStyle(fontSize: 18, color: Colors.white),
            )
          ],
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              FutureBuilder(
                  future: _asyncMethod(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        return playerBody();
                      } else {
                        return const Text('기기를 찾을 수 없습니다.');
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ])));
  }

  Widget playerBody() {
    return Column(children: [
      Column(
        children: [
          SizedBox(
              width: 304,
              height: 304,
              child: Image.asset('assets/app_icon.png', fit: BoxFit.contain)),
          const SizedBox(height: 24),
          Text('$trackTitle ',
              style: const TextStyle(
                fontSize: 22,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
              )),
          const Text('author', style: TextStyle(fontSize: 17)),
          const SizedBox(height: 34),
        ],
      ),
      Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            simpleIconButton(Icons.skip_previous, 40, () async {
              fastRewindClick();
              await saveSelectedTrack(trackTitle!);
            }),
            const SizedBox(width: 28),
            playIconButton(
                Icons.play_arrow, Icons.pause_circle_outline, 40, isPlaying,
                () async {
              setState(() {
                isPlaying = !isPlaying;
              });
              if (isPlaying) {
                await trackPlay('ready', '$trackTitle.wav');
              } else {
                await playStop();
              }
            }),
            const SizedBox(width: 28),
            simpleIconButton(Icons.skip_next, 40, () async {
              setState(() {
                fastForwardClick();
                isPlaying = true;
              });
              await saveSelectedTrack(trackTitle!);
            }),
            // if (trackPlayList.isNotEmpty)
          ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          simpleOutlineButton('UP', Icons.volume_up_outlined, 40, () {
            statusVolume().then((value) {
              currentVolume = value;
              volumeUp(currentVolume!);
              // if (currentVolume == 100) {
              //   warningSnackBar(context, '최대 볼륨.', '현재 최대 볼륨입니다.');
              // }
            });
          }),
          const SizedBox(width: 10),
          simpleOutlineButton('DOWN', Icons.volume_down_outlined, 40, () {
            statusVolume().then((value) {
              currentVolume = value;
              volumeDown(currentVolume!);
              // if (currentVolume! < 10) {
              //   warningSnackBar(context, '최저 볼륨.', '현재 최저 볼륨입니다.');
              // }
            });
          }),
        ],
      )
    ]);
  }

//여기서부턴 함수들을 정의합니다.
  void fastRewindClick() async {
    int currentIndex = trackPlayList.indexOf('$trackTitle.wav');
    if (currentIndex != -1) {
      if (currentIndex - 1 >= 0) {
        trackTitle = trackPlayList[currentIndex - 1].split('.wav')[0];
      } else {
        trackTitle = trackPlayList[trackPlayList.length - 1].split('.wav')[0];
      }
    }
    await playStop();
    await trackPlay('ready', '${trackTitle!}.wav');
    setState(() {
      isPlaying = true;
    });
  }

  void fastForwardClick() async {
    int currentIndex = trackPlayList.indexOf('$trackTitle.wav');
    if (currentIndex != -1) {
      if (currentIndex + 1 < trackPlayList.length) {
        trackTitle = trackPlayList[currentIndex + 1].split('.wav')[0];
      } else {
        trackTitle = trackPlayList[0].split('.wav')[0];
      }
    }
    await playStop();
    await trackPlay('ready', '${trackTitle!}.wav');
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> initTrackTitle(trackPlayList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTrackTitle = prefs.getString('selected_track');
    trackTitle = savedTrackTitle ?? trackPlayList[0].split('.wav')[0];
  }

  Future<void> volumeUp(int currentVolume) async {
    int volumeUp = currentVolume + 10;
    await httpGet(path: '/control/volume/$volumeUp');
  }

  Future<void> volumeDown(int currentVolume) async {
    int volumeDown = currentVolume - 10;
    await httpGet(path: '/control/volume/$volumeDown');
  }

  Future<int> statusVolume() async {
    http.Response resp = await httpGet(path: '/api/status/volume');
    Map<String, dynamic> jsonResp = jsonDecode(resp.body);
    return jsonResp['res'];
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
      print(ipv4Addresses);
    });
  }
}
