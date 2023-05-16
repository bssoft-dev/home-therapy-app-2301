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

Future<int> httpGet({required String path}) async {
  String baseUrl = 'https://172.30.1.51:8080$path';
  try {
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
    });
    try {
      Map<String, dynamic> resBody =
          jsonDecode(utf8.decode(response.bodyBytes));
      resBody['statusCode'] = response.statusCode;
      return resBody['statusCode'];
    } catch (e) {
      // response body가 json이 아닌 경우
      return 490;
    }
  } catch (e) {
    // 서버가 응답하지 않는 경우
    httpFailureNotice();
    return 503;
  }
}
