import 'package:shared_preferences/shared_preferences.dart';

import 'package:home_therapy_app/utils/http_request.dart';

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
