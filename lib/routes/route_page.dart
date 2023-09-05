import 'package:get/get.dart';

import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/screens/home.dart';
import 'package:home_therapy_app/screens/settings_drawer.dart';
import 'package:home_therapy_app/screens/track_players.dart';

class RoutePage {
  static final page = [
    GetPage(
      name: RouteName.home,
      page: () => const Home(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteName.therapyDevice,
      page: () => const TrackDevice(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteName.therapyDeviceManage,
      page: () => const Settings(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 150),
    ),
  ];
}
