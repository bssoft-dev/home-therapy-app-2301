import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_therapy_app/routes.dart';
import 'package:home_therapy_app/widgets/appBar-widget.dart';

void main() {
  runApp(const HomeTherapyApp());
}

class HomeTherapyApp extends StatelessWidget {
  const HomeTherapyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/appBackground.PNG"),
            fit: BoxFit.cover,
          ),
        ),
        child: GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
          initialRoute: '/',
          getPages: routeList,
          home: const HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: basicAppBar('Home Therapy App', context, _scaffoldKey),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/apiTest');
              },
              child: const Text('api 테스트 페이지로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
