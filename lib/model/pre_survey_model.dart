class preSurvey {
  Apartment? apartment;
  Pss? pss;
  Tipi? tipi;

  preSurvey({this.apartment, this.pss, this.tipi});

  preSurvey.fromJson(Map<String, dynamic> json) {
    apartment = json['apartment'] != null
        ? new Apartment.fromJson(json['apartment'])
        : null;
    pss = json['pss'] != null ? new Pss.fromJson(json['pss']) : null;
    tipi = json['tipi'] != null ? new Tipi.fromJson(json['tipi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.apartment != null) {
      data['apartment'] = this.apartment!.toJson();
    }
    if (this.pss != null) {
      data['pss'] = this.pss!.toJson();
    }
    if (this.tipi != null) {
      data['tipi'] = this.tipi!.toJson();
    }
    return data;
  }
}

class Apartment {
  List<int>? surveyA1;
  List<int>? surveyA2;
  List<int>? surveyA3;
  List<int>? surveyA4;
  List<int>? surveyA5;

  Apartment(
      {this.surveyA1,
      this.surveyA2,
      this.surveyA3,
      this.surveyA4,
      this.surveyA5});

  Apartment.fromJson(Map<String, dynamic> json) {
    surveyA1 = json['surveyA1'].cast<int>();
    surveyA2 = json['surveyA2'].cast<int>();
    surveyA3 = json['surveyA3'].cast<int>();
    surveyA4 = json['surveyA4'].cast<int>();
    surveyA5 = json['surveyA5'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyA1'] = this.surveyA1;
    data['surveyA2'] = this.surveyA2;
    data['surveyA3'] = this.surveyA3;
    data['surveyA4'] = this.surveyA4;
    data['surveyA5'] = this.surveyA5;
    return data;
  }
}

class Pss {
  List<int>? surveyP;

  Pss({this.surveyP});

  Pss.fromJson(Map<String, dynamic> json) {
    surveyP = json['surveyP'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyP'] = this.surveyP;
    return data;
  }
}

class Tipi {
  List<int>? surveyT;

  Tipi({this.surveyT});

  Tipi.fromJson(Map<String, dynamic> json) {
    surveyT = json['surveyT'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyT'] = this.surveyT;
    return data;
  }
}
