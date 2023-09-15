class userInfo {
  String? username;
  String? age;
  String? job;
  String? sn;

  userInfo({this.username, this.age, this.job, this.sn});

  userInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    age = json['age'];
    job = json['job'];
    sn = json['sn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['age'] = this.age;
    data['job'] = this.job;
    data['sn'] = this.sn;
    return data;
  }
}
