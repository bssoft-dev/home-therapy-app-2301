import 'package:get/get.dart';
import 'package:home_therapy_app/utils/current_version.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/widgets/survey_dialog/pre_noise_survey_dialog.dart';
import 'package:home_therapy_app/widgets/track_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/utils/main_color.dart';
import 'package:home_therapy_app/screens/settings_page.dart';
import 'package:home_therapy_app/widgets/background_container_widget.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:lottie/lottie.dart';

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
    checkVersion();
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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: mainColor.mainColor().withOpacity(0.05),
          ),
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: mainColor.mainColor().withOpacity(0.05),
            ),
            padding: const EdgeInsets.all(10),
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
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Lottie.asset(
                'assets/lottie/click.json',
                width: 50,
                height: 50,
                repeat: true,
                animate: true,
              ),
              const SizedBox(
                width: 4,
              ),
              const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '큰 원을 클릭해주세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(100),
              //     color: mainColor.mainColor(),
              //   ),
              //   child: const SizedBox(width: 10),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: mainColor.mainColor().withOpacity(0.7),
                ),
                child: simpleIconButton(
                  Icons.tune_outlined,
                  25,
                  Colors.white,
                  () {
                    Get.toNamed('trackMixing');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
