import 'package:flutter/material.dart';
import 'package:home_therapy_app/widgets/custom_button_widget.dart';
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
  double _firstvoluemValue = 0;
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
                      color: mainColor.mainColor(),
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
                      color: mainColor.mainColor()),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: mainColor.mainColor().withOpacity(0.3),
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
                      color: mainColor.mainColor().withOpacity(0.3)),
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
                color: mainColor.mainColor().withOpacity(0.3),
                thicknessUnit: GaugeSizeUnit.logicalPixel,
              ),
              pointers: [
                RangePointer(
                  value: _firstvoluemValue, // We declared this in state class.
                  enableDragging: true,
                  color: mainColor.mainColor(),
                  width: 100,
                  onValueChanged: onVolumeChanged,
                ),
                NeedlePointer(
                    value: _firstvoluemValue,
                    enableDragging: true,
                    onValueChanged: onVolumeChanged,
                    needleColor: mainColor.mainColor(),
                    needleStartWidth: 1.5,
                    needleEndWidth: 1.5,
                    needleLength: 0.8,
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        borderColor: mainColor.mainColor(),
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
                isPlaying: false,
                text: '믹싱 미리듣기',
                icon: Icons.play_arrow,
                alternateIcon: Icons.pause_circle_outline,
                size: 30,
                onPressed: () => print('믹싱 미리듣기 api 연결')),
            simpleOutlineButton(
                isPlaying: false,
                text: '믹싱 저장하기',
                icon: Icons.save,
                size: 30,
                onPressed: () => print('믹싱 저장 api 연결')),
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
