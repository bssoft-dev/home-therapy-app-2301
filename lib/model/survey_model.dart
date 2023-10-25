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
  List? noiseType;
  int? preEmotion;
  int? preAwake;
  List<dynamic>? tracks;
  List? comportPlotRating;
  int? postEmotion;
  int? postAwake;
  int? version;

  SurveyResult({
    this.sn,
    this.username,
    this.noise,
    this.noiseType,
    this.preEmotion,
    this.preAwake,
    this.tracks,
    this.comportPlotRating,
    this.postEmotion,
    this.postAwake,
    this.version
  });

  SurveyResult.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    username = json['username'];
    noise = json['noise'];
    noiseType = json['noiseType'];
    preEmotion = json['preEmotion'];
    preAwake = json['preAwake'];
    tracks = json['tracks'];
    comportPlotRating = json['comportPlot'];
    postEmotion = json['postEmotion'];
    postAwake = json['postAwake'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['username'] = this.username;
    data['noise'] = this.noise;
    data['noiseType'] = this.noiseType;
    data['preEmotion'] = this.preEmotion;
    data['preAwake'] = this.preAwake;
    data['tracks'] = this.tracks;
    data['comportPlotRating'] = this.comportPlotRating;
    data['postEmotion'] = this.postEmotion;
    data['postAwake'] = this.postAwake;
    data['version'] = this.version;
    return data;
  }
}
