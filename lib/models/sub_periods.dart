
class SubPeriods {
  final num day;
  final String time;

  SubPeriods({this.day, this.time});

  factory SubPeriods.fromJson(Map<String, dynamic> json) {
    return SubPeriods(
      day: json['day'],
      time: json['time'],
    );
  }
}
