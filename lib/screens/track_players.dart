import 'dart:io';
import 'dart:convert';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:home_therapy_app/utils/http_request.dart';
import 'package:home_therapy_app/widgets/track_widget.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color_widget.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/device_info_dialog_widget.dart';
import 'package:home_therapy_app/widgets/device_scann_dialog_widget.dart';

class TrackPlayers extends StatefulWidget {
  const TrackPlayers({super.key});

  @override
  State<TrackPlayers> createState() => _TrackPlayersState();
}

class _TrackPlayersState extends State<TrackPlayers>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  late final AnimationController _lottieController;

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
    _lottieController = AnimationController(vsync: this);
  }

  Future<bool> _asyncMethod() async {
    await getIpAddress();
    bool isDeviceConnected = await checkDeviceConnected();
    if (isDeviceConnected == true) {
      var response = await playList();
      if (response == 503) {
        return false;
      }
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
        // endDrawer: Drawer(),
        extendBodyBehindAppBar: true,
        body: backgroundContainer(
          context,
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ])),
        ));
  }

  Widget playerBody() {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: mainColor.mainColor(),
        ),
        child: GestureDetector(
          onTap: () {
            if (isPlaying == true) {
              _lottieController.stop();
              isPlaying = false;
            } else {
              _lottieController.repeat();
              isPlaying = true;
            }
          },
          child: Lottie.asset(
            'assets/lottie/main_play.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,
            controller: _lottieController,
            onLoaded: (composition) {
              _lottieController.duration = composition.duration;
            },
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mainColor.mainColor(),
              ),
              child:
                  simpleIconButton(Icons.volume_mute, 25, Colors.white, () {})),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mainColor.mainColor(),
              ),
              child: simpleIconButton(
                  Icons.tune_outlined, 25, Colors.white, () {}))
        ],
      ),
    ]);
  }

//여기서부턴 함수들을 정의합니다.
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
      // debugPrint('$ipv4Addresses');
    });
  }
}
