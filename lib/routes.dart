import 'package:get/get.dart';
import 'package:home_therapy_app/main.dart';

List<GetPage<dynamic>> routeList = [
  GetPage(name: '/', page: () => const HomePage()),
  // history reset is a dialog, not a route
];
