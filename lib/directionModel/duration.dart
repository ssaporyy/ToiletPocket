class Duration {
  final String text;
  final int value;

  Duration({this.text, this.value});

  factory Duration.fromJson(Map<String, dynamic> json) {
    return new Duration(text: json['text'], value: json['value']);
  }
}
