import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:home_therapy_app/screens/track_player.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class DeviceScannDialog extends StatefulWidget {
  const DeviceScannDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeviceScannDialogState();
}

class _DeviceScannDialogState extends State<DeviceScannDialog> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> liveIpAddresses = [];
  bool _isScanning = false;
  bool _isInitialScan = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Center(child: Text('홈테라피 선택', style: TextStyle(fontSize: 20))),
          if (Platform.isIOS)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text('주변기기가 검색되지 않는 경우,\n블루투스가 켜져있는지 확인해주세요.'),
            ),
          if (liveIpAddresses.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text(
                    '검색된 IP 주소',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: liveIpAddresses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.device_hub), // 기기 아이콘
                          const SizedBox(width: 8),
                          Text(
                            liveIpAddresses[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              saveStoredValue(
                                  'therapy_device', liveIpAddresses[index]);
                              successSnackBar(
                                  context, '등록완료', '홈세라피 기가가 등록되었습니다.');
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const trackPlayer()));
                              checkStoredValues();
                            },
                            child: const Text('선택'),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (_isScanning) {
                    stopScanning();
                  } else {
                    startScanning();
                  }
                },
                icon: Icon(
                    _isInitialScan ? Icons.search_outlined : Icons.refresh),
                label: Text(_isInitialScan ? "검색" : "재검색"),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  stopScanning();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
                label: const Text("닫기"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startScanning() {
    setState(() {
      _isScanning = true;
      _isInitialScan = false;
    });
    scanIpAddress();
  }

  void stopScanning() {
    setState(() {
      _isScanning = false;
    });
  }

  Future<List<String>> scanIpAddress() async {
    liveIpAddresses.clear();
    const port = [80, 8080];
    final stream80 = NetworkAnalyzer.discover2(
      '172.30.1',
      port[1],
      timeout: Duration(milliseconds: 1000),
    );

    int found = 0;
    await for (NetworkAddress addr in stream80) {
      if (addr.exists) {
        found++;
        print('Found device: ${addr.ip}:${port[1]}');
        liveIpAddresses.add('${addr.ip}');
      }
    }
    print('Finish. Found $found device(s)');

    liveIpAddresses.sort((a, b) {
      final aLastNumber = int.parse(a.split('.').last);
      final bLastNumber = int.parse(b.split('.').last);
      return aLastNumber.compareTo(bLastNumber);
    });
    return liveIpAddresses;
  }
}
