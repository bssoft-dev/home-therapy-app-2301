class Survey {
  SurveyResult? surveyResult;

  Survey({this.surveyResult});

  Survey.fromJson(Map<String, dynamic> json) {
    surveyResult = json['surveyResult'] != null
        ? SurveyResult.fromJson(json['surveyResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (surveyResult != null) {
      data['surveyResult'] = surveyResult!.toJson();
    }
    return data;
  }
}

class SurveyResult {
  String? sn;
  String? username;
  bool? noise;
  List? noiseType;
  int? preEmotion;
  int? preAwake;
  List<dynamic>? tracks;
  List? wordPositionRating;
  int? postEmotion;
  int? postAwake;
  int? version;
  int? postNoise;

  SurveyResult({
    this.sn,
    this.username,
    this.noise,
    this.noiseType,
    this.preEmotion,
    this.preAwake,
    this.tracks,
    this.wordPositionRating,
    this.postEmotion,
    this.postAwake,
    this.version,
    this.postNoise,
  });

  SurveyResult.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    username = json['username'];
    noise = json['noise'];
    noiseType = json['noiseType'];
    preEmotion = json['preEmotion'];
    preAwake = json['preAwake'];
    tracks = json['tracks'];
    wordPositionRating = json['wordPosition'];
    postEmotion = json['postEmotion'];
    postAwake = json['postAwake'];
    version = json['version'];
    postNoise = json['postNoise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sn'] = sn;
    data['username'] = username;
    data['noise'] = noise;
    data['noiseType'] = noiseType;
    data['preEmotion'] = preEmotion;
    data['preAwake'] = preAwake;
    data['tracks'] = tracks;
    data['wordPositionRating'] = wordPositionRating;
    data['postEmotion'] = postEmotion;
    data['postAwake'] = postAwake;
    data['version'] = version;
    data['postNoise'] = postNoise;
    return data;
  }
}
