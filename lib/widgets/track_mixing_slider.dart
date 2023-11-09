import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/utils/http_request_api.dart';
import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:home_therapy_app/utils/track_play_api.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
import 'package:home_therapy_app/widgets/noti_snackbar_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class TrackMixingSlider extends StatefulWidget {
  TrackMixingSlider(
      {super.key, required this.trackSelectOne, required this.trackSelectTwo});
  String? trackSelectOne;
  String? trackSelectTwo;

  @override
  State<TrackMixingSlider> createState() => _TrackMixingSliderState();
}

class _TrackMixingSliderState extends State<TrackMixingSlider> {
  TextEditingController mixingTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _firstvoluemValue = 0;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: mainColor.mainColor().withOpacity(0.65),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${widget.trackSelectOne}',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Text(
                  _firstvoluemValue.toStringAsFixed(0),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: mainColor.mainColor().withOpacity(0.65)),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: mainColor.mainColor().withOpacity(0.35),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${widget.trackSelectTwo}',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
                Text(
                  '${(_firstvoluemValue - 100).toInt().abs()}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: mainColor.mainColor().withOpacity(0.35)),
                )
              ],
            )
          ],
        ),
        Center(
            child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              ticksPosition: ElementsPosition.outside,
              labelsPosition: ElementsPosition.outside,
              startAngle: 270,
              endAngle: 270,
              useRangeColorForAxis: true,
              interval: 10,
              axisLabelStyle: const GaugeTextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15),
              majorTickStyle: const MajorTickStyle(
                  length: 0.15, lengthUnit: GaugeSizeUnit.factor, thickness: 3),
              minorTicksPerInterval: 4,
              labelOffset: 15,
              minorTickStyle: const MinorTickStyle(
                  length: 0.04, lengthUnit: GaugeSizeUnit.factor, thickness: 1),
              axisLineStyle: AxisLineStyle(
                thickness: 100,
                color: mainColor.mainColor().withOpacity(0.35),
                thicknessUnit: GaugeSizeUnit.logicalPixel,
              ),
              pointers: [
                RangePointer(
                  value: _firstvoluemValue, // We declared this in state class.
                  enableDragging: true,
                  color: mainColor.mainColor().withOpacity(0.65),
                  width: 100,
                  onValueChanged: onVolumeChanged,
                ),
                NeedlePointer(
                    value: _firstvoluemValue,
                    enableDragging: true,
                    onValueChanged: onVolumeChanged,
                    needleColor: mainColor.mainColor().withOpacity(0.65),
                    needleStartWidth: 1.5,
                    needleEndWidth: 1.5,
                    needleLength: 0.8,
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        borderColor: mainColor.mainColor().withOpacity(0.65),
                        borderWidth: 10,
                        knobRadius: 20,
                        sizeUnit: GaugeSizeUnit.logicalPixel))
              ],
            )
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            simpleOutlineButton(
              isPlaying: isPlaying,
              text: '믹싱 미리듣기',
              icon: Icons.play_arrow_rounded,
              alternateIcon: Icons.pause_circle_outline,
              size: 30,
              onPressed: () async {
                String? deviceIP = await getStoredValue('therapy_device');
                httpPost(
                        path: '/api/mix/preview',
                        data: {
                          'files': [
                            widget.trackSelectOne,
                            widget.trackSelectTwo
                          ],
                          'ratio': [
                            (_firstvoluemValue.toInt() / (100)),
                            (((_firstvoluemValue.toInt() - 100).abs()) / 100)
                          ],
                        },
                        deviceIP: '$deviceIP')
                    .then((value) {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying == false) {
                      playStop();
                    }
                  });
                });
              },
            ),
            simpleOutlineButton(
                isPlaying: false,
                text: '믹싱 저장하기',
                icon: Icons.save,
                size: 30,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('믹싱 저장하기'),
                            content: Form(
                              key: _formKey,
                              child: TextFormField(
                                // autovalidateMode: AutovalidateMode.always,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value == '') {
                                    return '믹싱 이름을 입력해주세요.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  mixingTitleController.text = value!;
                                },
                                controller: mixingTitleController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '믹싱 이름을 입력해주세요.'),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('취소')),
                              TextButton(
                                  onPressed: () async {
                                    String? deviceIP =
                                        await getStoredValue('therapy_device');

                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      httpPost(
                                          path:
                                              '/api/mix/save/${mixingTitleController.text}',
                                          data: {
                                            'files': [
                                              widget.trackSelectOne,
                                              widget.trackSelectTwo
                                            ],
                                            'ratio': [
                                              (_firstvoluemValue.toInt() /
                                                  (100)),
                                              (((_firstvoluemValue.toInt() -
                                                          100)
                                                      .abs()) /
                                                  100)
                                            ],
                                          },
                                          deviceIP: '$deviceIP');

                                      Get.offNamedUntil(
                                          '/therapyDevice', (route) => false);
                                      // ignore: use_build_context_synchronously
                                      successSnackBar(context, '저장이 완료되었습니다.',
                                          '믹싱페이지에서 추가된 음원을 확인해주세요');
                                    }
                                  },
                                  child: const Text('저장'))
                            ],
                          ));
                }),
          ],
        )
      ],
    );
  }

  void onVolumeChanged(double value) {
    setState(() {
      _firstvoluemValue = value;
    });
  }
}
