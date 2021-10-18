class Open {
  int day;
  String time;

  Open({this.day, this.time});

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }
}