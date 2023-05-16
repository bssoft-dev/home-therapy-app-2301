import 'package:get/get.dart';
import 'package:home_therapy_app/main.dart';
import 'package:home_therapy_app/screens/apiTest.dart';

List<GetPage<dynamic>> routeList = [
  GetPage(name: '/', page: () => const HomePage()),
  GetPage(name: '/apiTest', page: () => const ApiTestScreen()),
  // history reset is a dialog, not a route
];
