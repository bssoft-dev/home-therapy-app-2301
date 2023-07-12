import 'package:get/get.dart';

import 'package:home_therapy_app/routes/route_name.dart';
import 'package:home_therapy_app/screens/home.dart';
import 'package:home_therapy_app/screens/track_player.dart';

class RoutePage {
  static final page = [
    GetPage(
      name: RouteName.home,
      page: () => const Home(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteName.therapyDevice,
      page: () => const TrackPlayer(),
      transition: Transition.noTransition,
    ),
  ];
}
