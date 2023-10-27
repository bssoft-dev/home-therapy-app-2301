import 'package:home_therapy_app/utils/share_rreferences_future.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:home_therapy_app/utils/http_request_api.dart';

Future<void> saveSelectedTrack(String trackTitle) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('selected_track', trackTitle);
}

Future trackPlay<int>(String reqType, String wavfile) async {
  String? deviceIP = await getStoredValue('therapy_device');
  return await httpGet(
      path: '/control/play/$reqType/$wavfile', deviceIP: deviceIP!);
}

Future playStop<int>() async {
  String? deviceIP = await getStoredValue('therapy_device');
  return await httpGet(path: '/control/stop', deviceIP: deviceIP!);
}

Future playList<List>() async {
  String? deviceIP = await getStoredValue('therapy_device');
  return await httpGet(path: '/api/playlist', deviceIP: deviceIP!);
}
