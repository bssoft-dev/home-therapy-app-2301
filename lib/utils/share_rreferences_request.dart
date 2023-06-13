import 'package:shared_preferences/shared_preferences.dart';

// 기기가 등록되어 있는지 확인합니다.
Future<bool> checkDeviceConnected() async {
  String? connected = await getStoredValue('therapy_device');
  bool deviceConnected;
  if (connected == null) {
    deviceConnected = false;
  } else {
    deviceConnected = true;
  }
  return deviceConnected;
}

// 모든 키(key)와 해당 값을 출력합니다.
Future<void> checkStoredValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.getKeys().forEach((key) {
    dynamic value = prefs.get(key);
    print('$key: $value');
  });
}

// 키에 해당하는 값만 가져옵니다.
Future<String?> getStoredValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

// 키에 해당하는 키와 값을 가져옵니다.
Future<Map<String, dynamic>> getAllStoredValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();
  Map<String, dynamic> values = {};

  for (String key in keys) {
    values[key] = prefs.get(key);
  }

  return values;
}

// 키를 지정하고 값과 같이 저장합니다.
Future<void> saveStoredValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

// 키를 검색하여 해당 값을 삭제합니다.
Future<void> removeStoredValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

// 모든 값을 삭제합니다.
Future<void> clearAllStoredValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
