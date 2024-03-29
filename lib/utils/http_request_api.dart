import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

void httpFailureNotice() {
  Get.snackbar('통신에러', '서버와 통신이 되지 않습니다. 인터넷 연결 확인 후 다시 시도해보세요.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}

httpGet({required String path, required String deviceIP}) async {
  String baseUrl = 'http://$deviceIP:23019$path';
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    return response;
  } catch (e) {
    // 서버가 응답하지 않는 경우
    httpFailureNotice();
    return 503;
  }
}

httpPost(
    {required String path, required Map data, required String deviceIP}) async {
  String baseUrl = 'http://$deviceIP:23019$path';
  var body = jsonEncode(data);
  print(body);
  try {
    http.Response response =
        await http.post(Uri.parse(baseUrl), body: body, headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    return response.statusCode;
  } catch (e) {
    // 서버가 응답하지 않는 경우
    httpFailureNotice();
    return 503;
  }
}

httpPostServer({
  required String path,
  required Map data,
}) async {
  String baseUrl = 'https://home-therapy.bs-soft.co.kr/$path';
  var body = jsonEncode(data);
  debugPrint(baseUrl);
  debugPrint(body);
  try {
    http.Response response =
        await http.post(Uri.parse(baseUrl), body: body, headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    return response.statusCode;
  } catch (e) {
    // 서버가 응답하지 않는 경우
    httpFailureNotice();
    return 503;
  }
}

httpGetServer({
  required String path,
}) async {
  String baseUrl = 'https://home-therapy.bs-soft.co.kr/$path';
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    Map<String, dynamic> resBody = jsonDecode(utf8.decode(response.bodyBytes));
    return resBody['result'];
  } catch (e) {
    // 서버가 응답하지 않는 경우
    httpFailureNotice();
    return 503;
  }
}
