import 'package:get/get.dart';
import 'package:home_therapy_app/screens/track_player.dart';

List<GetPage<dynamic>> routeList = [
  GetPage(name: '/', page: () => const trackPlayer()),
  // history reset is a dialog, not a route
];
