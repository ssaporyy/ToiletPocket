class Durations{
  final String text;
  final int value;

  Durations({this.text, this.value});

  factory Durations.fromJson(Map<String, dynamic> json) {
    return new Durations(text: json['text'], value: json['value']);
  }
}