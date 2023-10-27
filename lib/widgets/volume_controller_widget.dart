import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/http_request_api.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';

class VolumeController extends StatefulWidget {
  const VolumeController({super.key});

  @override
  State<VolumeController> createState() => _VolumeControllerState();
}

class _VolumeControllerState extends State<VolumeController> {
  @override
  void initState() {
    statusVolume();
    super.initState();
  }

  double? currentVolume = 0.0;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: const SliderThemeData(
          showValueIndicator: ShowValueIndicator.onlyForContinuous),
      child: Slider(
          label: currentVolume != null
              ? currentVolume!.toInt().toString()
              : '', // null 체크 추가
          value: currentVolume ?? 0.0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              currentVolume = value;
              volumeChange(currentVolume!.toInt());
            });
          }),
    );
  }

  Future<void> statusVolume() async {
    String? deviceIP = await getStoredValue('therapy_device');
    http.Response resp =
        await httpGet(path: '/api/status/volume', deviceIP: deviceIP!);
    Map<String, dynamic> jsonResp = jsonDecode(resp.body);
    setState(() {
      currentVolume = jsonResp['res'].toDouble();
    });
  }

  Future<void> volumeChange(int currentVolume) async {
    String? deviceIP = await getStoredValue('therapy_device');
    await httpGet(path: '/control/volume/$currentVolume', deviceIP: deviceIP!);
  }
}
