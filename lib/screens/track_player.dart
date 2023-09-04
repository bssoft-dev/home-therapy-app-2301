import 'dart:io';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/widgets/track_widget.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/widgets/text_field_widget.dart';
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
  late List<bool> trackPlayIndex;
  String? trackTitle;
  bool isPlaying = false;
  bool isListPlaying = false;
  bool? deviceConnected;
  int? currentVolume;
  Future<bool>? asyncMethodFuture;

  @override
  void initState() {
    super.initState();
    asyncMethodFuture = _asyncMethod();
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
    trackPlayIndex = List<bool>.generate(
        trackPlayList.length, (int index) => false,
        growable: true);
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
                children: <Widget>[
              FutureBuilder<bool>(
                  future: asyncMethodFuture,
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
      trackList(trackPlayList, trackPlayIndex),
      const Divider(
        color: Colors.black,
        thickness: 1,
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Lottie.asset('assets/lottie/recommend_title.json',
                width: 50, height: 50, fit: BoxFit.fill, animate: true),
          ),
          const Text('Recommend Track',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
      Lottie.asset('assets/lottie/recommend_playing.json',
          width: 200, height: 200, fit: BoxFit.fill, animate: isPlaying),
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
      const SizedBox(
        height: 20,
      ),
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
      ),
    ]);
  }

  Widget trackList(trackPlayList, trackPlayIndex) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: mainColor.mainColor(),
                  ),
                  child: Lottie.asset('assets/lottie/track_list.json',
                      width: 40, height: 40, fit: BoxFit.fill, animate: true),
                )),
            const Text('Track List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
        // SizedBox(
        //   height: 20,
        // ),
        SingleChildScrollView(
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
                          Text('${trackPlayList[index]}'),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: playIconButton(
                                Icons.play_arrow,
                                Icons.pause_circle_outline,
                                40,
                                trackPlayIndex[index], () async {
                              setState(() {
                                trackPlayIndex[index] = !trackPlayIndex[index];
                              });
                              if (trackPlayIndex[index]) {
                                await trackPlay(
                                    'ready', '${trackPlayList[index]}');
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
    );
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
    String? deviceIP = await getStoredValue('therapy_device');

    int volumeUp = currentVolume + 10;
    await httpGet(path: '/control/volume/$volumeUp', deviceIP: deviceIP!);
  }

  Future<void> volumeDown(int currentVolume) async {
    String? deviceIP = await getStoredValue('therapy_device');

    int volumeDown = currentVolume - 10;
    await httpGet(path: '/control/volume/$volumeDown', deviceIP: deviceIP!);
  }

  Future<int> statusVolume() async {
    String? deviceIP = await getStoredValue('therapy_device');
    http.Response resp =
        await httpGet(path: '/api/status/volume', deviceIP: deviceIP!);
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
      // print(ipv4Addresses);
    });
  }
}
