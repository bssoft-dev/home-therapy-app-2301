import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';

import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';

class DeviceScannDialog extends StatefulWidget {
  final List<String> filteredAddresses;

  const DeviceScannDialog(this.filteredAddresses, {Key? key}) : super(key: key);
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
          const SizedBox(height: 20),
          const Center(
            child: Text(
              '홈테라피 선택',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 4, 20, 20),
            child: liveIpAddresses.isNotEmpty
                ? Column(
                    children: [
                      const Text(
                        '검색된 IP 주소',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff5a5a5a),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: liveIpAddresses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: mainColor
                                            .mainColor()
                                            .withOpacity(0.65),
                                      ),
                                      child: Transform.translate(
                                        offset: const Offset(0, -1),
                                        child: const Icon(
                                          Icons.device_hub_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ), // 기기 아이콘
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Text(
                                        liveIpAddresses[index],
                                        style: const TextStyle(
                                            fontSize: 20, height: 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await saveStoredValue(
                                      'therapy_device', liveIpAddresses[index]);
                                  // ignore: use_build_context_synchronously
                                  successSnackBar(
                                      context, '등록완료', '홈 스피커 기기가 등록되었습니다.');
                                  Get.offAllNamed('/therapyDevice',
                                      arguments: Get.context);
                                },
                                child: const Text(
                                  '선택',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff8E8E8E),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 20,
                  ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  if (_isScanning) {
                    stopScanning();
                  } else {
                    startScanning();
                  }
                },
                icon: Icon(_isInitialScan
                    ? Icons.search_rounded
                    : Icons.refresh_rounded),
                label: Text(
                  _isInitialScan ? "검색" : "재검색",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  stopScanning();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text(
                  "닫기",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
    const port = [80, 23019];
    final stream80 = NetworkAnalyzer.discover2(
      widget.filteredAddresses[0],
      port[1],
      timeout: const Duration(milliseconds: 5000),
    );

    int found = 0;
    await for (NetworkAddress addr in stream80) {
      debugPrint(addr.ip);
      if (addr.exists) {
        found++;
        debugPrint('Found device: ${addr.ip}:${port[1]}');
        setState(() {
          liveIpAddresses.add(addr.ip);
        });
      }
    }
    debugPrint('Finish. Found $found device(s)');

    liveIpAddresses.sort((a, b) {
      final aLastNumber = int.parse(a.split('.').last);
      final bLastNumber = int.parse(b.split('.').last);
      return aLastNumber.compareTo(bLastNumber);
    });
    return liveIpAddresses;
  }
}
