import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/emotion_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/track_play.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color.dart';
import 'package:home_therapy_app/screens/settings_drawer.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';

class DevicePlayer extends StatefulWidget {
  const DevicePlayer({super.key});

  @override
  State<DevicePlayer> createState() => _DevicePlayerState();
}

class _DevicePlayerState extends State<DevicePlayer>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  late final AnimationController _lottieController;

  bool isPlaying = false;
  Future<bool>? asyncMethodFuture;

  @override
  void initState() {
    super.initState();
    asyncMethodFuture = asyncTrackPlayListMethod();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // AnimationController를 dispose
    _lottieController.dispose();
    super.dispose();
  }

  // Future<bool> _asyncMethod() async {
  //   bool isDeviceConnected = await checkDeviceConnected();
  //   if (isDeviceConnected == true) {
  //     var response = await playList();
  //     if (response == 503) {
  //       return false;
  //     }
  //   }
  //   return isDeviceConnected;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        endDrawer: const Settings(),
        extendBodyBehindAppBar: true,
        body: backgroundContainer(
          context: context,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                FutureBuilder<bool>(
                    future: asyncMethodFuture,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data == true) {
                          return playerBody(context);
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

  Widget playerBody(BuildContext context) {
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
              emotionServeyDialog(
                  context: context,
                  lottieController: _lottieController,
                  isPlaying: isPlaying);
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
              child: simpleIconButton(Icons.volume_mute, 25, Colors.white, () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AlertDialog(
                              title: const Text('볼륨 조절'),
                              content: Slider(
                                value: 10,
                                max: 100,
                                onChanged: (double value) {},
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ]);
                    });
              })),
          const SizedBox(width: 10),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: mainColor.mainColor(),
              ),
              child:
                  simpleIconButton(Icons.tune_outlined, 25, Colors.white, () {
                Get.toNamed('trackMixing');
              }))
        ],
      ),
    ]);
  }
}
