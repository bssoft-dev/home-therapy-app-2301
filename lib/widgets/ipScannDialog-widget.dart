import 'dart:convert';
import 'dart:io'
    show InternetAddress, InternetAddressType, NetworkInterface, Platform;
import 'package:flutter/material.dart';

class IPScannDrawer extends StatefulWidget {
  const IPScannDrawer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IPScannDrawerState();
}

class _IPScannDrawerState extends State<IPScannDrawer> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> scanResultList = [];
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Center(child: Text('홈테라비 선택')),
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.55,
        //   width: MediaQuery.of(context).size.width * 0.8,
        //   child: ListView.separated(
        //     itemCount: scanResultList.length,
        //     itemBuilder: (context, index) {
        //       return listItem(scanResultList[index]);
        //     },
        //     separatorBuilder: (BuildContext context, int index) {
        //       return const Divider();
        //     },
        //   ),
        // ),
        if (Platform.isIOS)
          const Center(child: Text('주변기기가 검색되지 않는 경우,\n블루투스가 켜져있는지 확인해주세요.')),
        /* 장치 검색 or 검색 중지  */
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
            onPressed: scan,
            icon: Icon(_isScanning ? Icons.stop : Icons.refresh),
            label: Text(_isScanning ? "검색 중지" : "재검색"),
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
            label: const Text("닫기"),
          ),
        ]),
      ],
    );
  }

  Future<void> scan() async {
    if (mounted) {
      setState(() {
        _isScanning = true;
      });
    }
    await Future.delayed(Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isScanning = false;
      });
    }
  }
}
