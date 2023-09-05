import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/track_player_dialog_widget.dart';
import 'package:home_therapy_app/utils/background_container.dart';
import 'package:home_therapy_app/utils/main_color_widget.dart';
import 'package:home_therapy_app/widgets/device_info_dialog_widget.dart';
import 'package:home_therapy_app/widgets/device_scann_dialog_widget.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<bool>? asyncMethodFuture;
  String? trackTitle;
  @override
  void initState() {
    super.initState();
    asyncMethodFuture = asyncMethod();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> ipv4Addresses = [];
  late List<String> trackPlayList;
  late List<bool> trackPlayIndex;
  final MainColor mainColor = MainColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: mainColor.mainColor(),
                size: 50,
              ),
              onPressed: () => Navigator.pop(context)),
        ),
        body: backgroundContainer(
            context,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                settingTile('기기 검색', Icons.search, () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return DeviceScannDialog(ipv4Addresses);
                    },
                  );
                }),
                settingTile('기기 정보', Icons.info, () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const DeviceInfoDialog();
                    },
                  );
                }),
                settingTile('음원 미리듣기', Icons.audiotrack, () {
                  previewTrack(context);
                }),
              ],
            )));
  }
}

Widget settingTile(String title, IconData icon, void Function()? onTap) {
  final MainColor mainColor = MainColor();
  return Column(
    children: [
      ListTile(
        leading: Icon(
          icon,
          color: mainColor.mainColor(),
          size: 35,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: mainColor.mainColor(),
            fontSize: 20,
          ),
        ),
        onTap: onTap,
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: mainColor.mainColor(),
        ),
      ),
      Divider(
        color: mainColor.mainColor(),
        indent: 20,
        endIndent: 20,
      )
    ],
  );
}
