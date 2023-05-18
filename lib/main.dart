import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:home_therapy_app/routes.dart';
import 'package:home_therapy_app/utils/httpRequest.dart';
import 'package:home_therapy_app/widgets/CustomButton-widget.dart';
import 'package:home_therapy_app/widgets/appBar-widget.dart';
import 'package:home_therapy_app/widgets/mainColor-widget.dart';

void main() {
  runApp(HomeTherapyApp());
}

class HomeTherapyApp extends StatelessWidget {
  HomeTherapyApp({super.key});
  final MainColor mainColor = MainColor();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: mainColor.mainColor(),
      ),
      initialRoute: '/',
      getPages: routeList,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<String> trackPlayList;
  String? trackTitle;
  String? trackAuthor;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    initTrackTitle();
    playList().then((value) {
      setState(() {
        trackPlayList = jsonDecode(utf8.decode(value.bodyBytes)).cast<String>();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: basicAppBar(context, _scaffoldKey),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              Column(children: [
                SizedBox(
                    width: 304,
                    height: 304,
                    child: Image.asset('assets/app_icon.png',
                        fit: BoxFit.contain)),
                const SizedBox(height: 24),
                Column(children: [
                  Column(
                    children: [
                      Text('$trackTitle ',
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                          )),
                      const Text('author', style: TextStyle(fontSize: 17)),
                      const SizedBox(height: 34),
                    ],
                  ),
                  Text('재생바부분'),
                  const SizedBox(height: 48),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        simpleIconButton(Icons.fast_rewind, 40, () async {
                          fastRewindClick();
                          await saveSelectedTrack(trackTitle!);
                        }),
                        const SizedBox(width: 28),
                        playIconButton(
                            Icons.play_arrow,
                            Icons.pause_circle_outline,
                            40,
                            isPlaying, () async {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                          if (isPlaying) {
                            await trackPlay('ready', '${trackTitle!}.wav');
                          } else {
                            await playStop();
                          }
                        }),
                        const SizedBox(width: 28),
                        simpleIconButton(Icons.fast_forward, 40, () async {
                          fastForwardClick();
                          await saveSelectedTrack(trackTitle!);
                        })
                      ])
                ])
              ])
            ])));
  }

  void fastRewindClick() async {
    int currentIndex = trackPlayList.indexOf('${trackTitle!}.wav');
    if (currentIndex != -1) {
      if (currentIndex - 1 >= 0) {
        trackTitle = trackPlayList[currentIndex - 1].split('.wav')[0];
      } else {
        trackTitle = trackPlayList[trackPlayList.length - 1].split('.wav')[0];
      }
    }
    await playStop();
    await trackPlay('ready', '${trackTitle!}.wav');
    setState(() {
      isPlaying = true;
    });
  }

  void fastForwardClick() async {
    int currentIndex = trackPlayList.indexOf('${trackTitle!}.wav');
    if (currentIndex != -1) {
      if (currentIndex + 1 < trackPlayList.length) {
        trackTitle = trackPlayList[currentIndex + 1].split('.wav')[0];
      } else {
        trackTitle = trackPlayList[0].split('.wav')[0];
      }
    }
    await playStop();
    await trackPlay('ready', '${trackTitle!}.wav');
    setState(() {
      isPlaying = true;
    });
  }

  Future<void> initTrackTitle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTrackTitle = prefs.getString('selected_track');
    setState(() {
      trackTitle = savedTrackTitle ?? trackPlayList[0].split('.wav')[0];
    });
  }

  Future<void> saveSelectedTrack(String trackTitle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_track', trackTitle);
  }

  Future trackPlay<int>(String reqType, String wavfile) async {
    return await httpGet(path: '/control/play/$reqType/$wavfile');
  }

  Future playStop<int>() async {
    return await httpGet(path: '/control/stop');
  }

  Future playList<List>() async {
    return await httpGet(path: '/api/playlist');
  }
}
