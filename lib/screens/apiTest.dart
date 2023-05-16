import 'package:flutter/material.dart';
import 'package:home_therapy_app/utils/httpRequest.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({Key? key}) : super(key: key);

  @override
  State<ApiTestScreen> createState() => _ApiTestScreen();
}

class _ApiTestScreen extends State<ApiTestScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List songTitleList = ['자연의 소리.wav', 'singingball.wav', 'omg.wav'];
  String songTpye = 'ready';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text('Sound'),
            ],
          ),
        ));
  }

  Future<int> songPlay(String reqType, String wavfile) async {
    return await httpGet(path: '/play/$reqType/$wavfile');
  }

  Future<int> songStop() async {
    return await httpGet(path: '/stop');
  }
}
