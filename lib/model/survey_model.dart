class Survey {
  SurveyResult? surveyResult;

  Survey({this.surveyResult});

  Survey.fromJson(Map<String, dynamic> json) {
    surveyResult = json['surveyResult'] != null
        ? new SurveyResult.fromJson(json['surveyResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.surveyResult != null) {
      data['surveyResult'] = this.surveyResult!.toJson();
    }
    return data;
  }
}

class SurveyResult {
  String? sn;
  String? username;
  bool? noise;
  String? noiseType;
  int? noiseScore;
  int? preEmotion;
  int? preAwake;
  List<dynamic>? tracks;
  List<dynamic>? comportPlot;
  int? postEmotion;
  int? postAwake;

  SurveyResult({
    this.sn,
    this.username,
    this.noise,
    this.noiseType,
    this.noiseScore,
    this.preEmotion,
    this.preAwake,
    this.tracks,
    this.comportPlot,
    this.postEmotion,
    this.postAwake,
  });

  SurveyResult.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    username = json['username'];
    noise = json['noise'];
    noiseType = json['noiseType'];
    noiseScore = json['noiseScore'];
    preEmotion = json['preEmotion'];
    preAwake = json['preAwake'];
    tracks = json['tracks'];
    comportPlot = json['comportPlot'];
    postEmotion = json['postEmotion'];
    postAwake = json['postAwake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['username'] = this.username;
    data['noise'] = this.noise;
    data['noiseType'] = this.noiseType;
    data['noiseScore'] = this.noiseScore;
    data['preEmotion'] = this.preEmotion;
    data['preAwake'] = this.preAwake;
    data['tracks'] = this.tracks;
    data['comportPlot'] = this.comportPlot;
    data['postEmotion'] = this.postEmotion;
    data['postAwake'] = this.postAwake;
    return data;
  }
}
