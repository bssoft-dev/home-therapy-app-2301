import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadAssetImages(String imagePath) async {
  List<String> imagePaths = [];

  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  manifestMap.keys.forEach((String key) {
    if (key.startsWith('assets/survey/$imagePath/')) {
      imagePaths.add(key);
    }
  });

  return imagePaths;
}