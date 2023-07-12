import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_therapy_app/utils/share_rreferences_request.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';

class DeviceInfoDialog extends StatefulWidget {
  const DeviceInfoDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeviceInfoDialogState();
}

class _DeviceInfoDialogState extends State<DeviceInfoDialog> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? deviceIPName;

  @override
  void initState() {
    super.initState();
    getStoredValue('therapy_device').then((value) {
      setState(() {
        deviceIPName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          const Center(
              child: Text('홈테라피 기기 정보', style: TextStyle(fontSize: 20))),
          if (deviceIPName == null)
            const Column(children: [
              SizedBox(height: 16),
              Text('등록된 기기가 없습니다'),
              SizedBox(height: 16)
            ]),
          if (deviceIPName != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.device_hub), // 기기 아이콘
                      const SizedBox(width: 8),
                      Text(
                        '$deviceIPName',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  removeStoredValue('therapy_device');
                  successSnackBar(
                      context, '기기 삭제 완료', '$deviceIPName 기기가 삭제되었습니다.');
                  Navigator.pop(context);
                  Get.offAllNamed('/home');
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const TrackPlayer()));
                },
                icon: const Icon(Icons.close),
                label: const Text("삭제"),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_outlined),
                label: const Text("확인"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
