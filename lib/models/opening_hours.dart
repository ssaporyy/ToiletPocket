import 'dart:convert';

import 'package:flutter/foundation.dart';

class OpeningHours {
  final bool open_now;
  final List<String> weekday_text;
  OpeningHours({
    this.open_now,
    this.weekday_text,
  });
 
  Map<String, dynamic> toMap() {
    return {
      'open_now': open_now,
      'weekday_text': weekday_text,
    };
  }

  factory OpeningHours.fromMap(Map<String, dynamic> map) {
    return OpeningHours(
      open_now: map['open_now'],
      weekday_text: List<String>.from(map['weekday_text']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OpeningHours.fromJson(String source) => OpeningHours.fromMap(json.decode(source));

  @override
  String toString() => 'OpeningHours(open_now: $open_now, weekday_text: $weekday_text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OpeningHours &&
      other.open_now == open_now &&
      listEquals(other.weekday_text, weekday_text);
  }

  @override
  int get hashCode => open_now.hashCode ^ weekday_text.hashCode;
}
