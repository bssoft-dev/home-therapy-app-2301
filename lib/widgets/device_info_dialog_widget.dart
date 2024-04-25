import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
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
          const SizedBox(height: 20),
          const Center(
            child: Text(
              '홈테라피 기기 정보',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: deviceIPName == null
                ? const Text(
                    '등록된 기기가 없습니다',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff5a5a5a),
                    ),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: mainColor.mainColor().withOpacity(0.65),
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
                          Text(
                            '$deviceIPName',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  removeStoredValue('therapy_device');
                  successSnackBar(
                      context, '기기 삭제 완료', '$deviceIPName 기기가 삭제되었습니다.');
                  Get.offAllNamed('/home');
                },
                icon: const Icon(
                  Icons.close_rounded,
                ),
                label: const Text(
                  "삭제",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text(
                  "확인",
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
}
