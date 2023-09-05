import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/track_widget.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color_widget.dart';
import 'package:home_therapy_app/screens/settings_drawer.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';

class TrackDevice extends StatefulWidget {
  const TrackDevice({super.key});

  @override
  State<TrackDevice> createState() => _TrackDeviceState();
}

class _TrackDeviceState extends State<TrackDevice>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  late final AnimationController _lottieController;

  bool isPlaying = false;
  Future<bool>? asyncMethodFuture;

  @override
  void initState() {
    super.initState();
    asyncMethodFuture = _asyncMethod();
    _lottieController = AnimationController(vsync: this);
  }

  Future<bool> _asyncMethod() async {
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
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        endDrawer: const Settings(),
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
}
