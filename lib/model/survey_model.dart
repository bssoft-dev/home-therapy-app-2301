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
  String? username;
  String? sn;
  bool? noise;
  int? preEmotion;
  int? preAwake;
  List<dynamic>? tracks;
  List<double>? comportPloat;
  int? postEmotion;
  int? postAwake;

  SurveyResult(
      {this.username,
      this.sn,
      this.noise,
      this.preEmotion,
      this.preAwake,
      this.tracks,
      this.comportPloat,
      this.postEmotion,
      this.postAwake});

  SurveyResult.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    sn = json['sn'];
    noise = json['noise'];
    preEmotion = json['preEmotion'];
    preAwake = json['preAwake'];
    tracks = json['tracks'].cast<String>();
    comportPloat = json['comportPloat'].cast<int>();
    postEmotion = json['postEmotion'];
    postAwake = json['postAwake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['sn'] = this.sn;
    data['noise'] = this.noise;
    data['preEmotion'] = this.preEmotion;
    data['preAwake'] = this.preAwake;
    data['tracks'] = this.tracks;
    data['comportPloat'] = this.comportPloat;
    data['postEmotion'] = this.postEmotion;
    data['postAwake'] = this.postAwake;
    return data;
  }
}
