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
  String? noise;
  int? emotion;
  int? awakener;
  List<String>? trackList;
  List<int>? image;
  int? afEmotion;
  int? afAwakener;

  SurveyResult(
      {this.noise,
      this.emotion,
      this.awakener,
      this.trackList,
      this.image,
      this.afEmotion,
      this.afAwakener});

  SurveyResult.fromJson(Map<String, dynamic> json) {
    noise = json['noise'];
    emotion = json['emotion'];
    awakener = json['awakener'];
    trackList = json['trackList'].cast<String>();
    image = json['image'].cast<int>();
    afEmotion = json['afEmotion'];
    afAwakener = json['afAwakener'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noise'] = this.noise;
    data['emotion'] = this.emotion;
    data['awakener'] = this.awakener;
    data['trackList'] = this.trackList;
    data['image'] = this.image;
    data['afEmotion'] = this.afEmotion;
    data['afAwakener'] = this.afAwakener;
    return data;
  }
}
