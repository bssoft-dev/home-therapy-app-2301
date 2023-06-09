import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';

import 'package:home_therapy_app/widgets/appbar_widget.dart';
import 'package:home_therapy_app/widgets/main_color_widget.dart';
import 'package:home_therapy_app/widgets/device_info_dialog_widget.dart';
import 'package:home_therapy_app/widgets/device_scann_dialog_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final MainColor mainColor = MainColor();
  List<String> ipv4Addresses = [];

  @override
  void initState() {
    super.initState();
    getIpAddress();
    checkDeviceConnected().then((value) => setState(() {
          if (value == true) {
            Navigator.of(context).pop();
            Get.toNamed(RouteName.therapyDevice);
          }
        }));
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
        body: const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              Column(
                children: [
                  Icon(
                    Icons.phonelink_erase_outlined,
                    size: 304,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 24),
                  Text(
                    '등록된 기기가 없습니다.',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ])));
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
      print(ipv4Addresses);
    });
  }
}
