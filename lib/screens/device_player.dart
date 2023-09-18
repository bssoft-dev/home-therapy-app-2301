import 'package:get/get.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_noise_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:flutter/material.dart';
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

class _DevicePlayerState extends State<DevicePlayer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  Future<bool>? asyncMethodFuture;

  @override
  void initState() {
    super.initState();
    asyncMethodFuture = asyncTrackPlayListMethod();
  }

  @override
  void dispose() {
    // AnimationController를 dispose
    super.dispose();
  }

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
          color: mainColor.mainColor().withOpacity(0.1),
        ),
        child: GestureDetector(
          onTap: () async {
            final userCheck = await getStoredValue('username');
            if (userCheck != null) {
              noiseServeyDialog(context: context);
            } else {
              failSnackBar('오류', '개인정보를 먼저 입력해주세요.');
            }
          },
          child: Image.asset(
            'assets/app_main_image.png',
            width: 300,
            height: 300,
            fit: BoxFit.fill,
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
            child: const SizedBox(width: 10),
          ),
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
