import 'dart:convert';

import 'package:ToiletPocket/models/periods.dart';
import 'package:flutter/foundation.dart';

class OpeningHours {
  final bool open_now;
  final List<String> weekday_text;
  final List<Periods> periods;
  OpeningHours({
    this.open_now,
    this.weekday_text,
    this.periods,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      open_now: json['open_now'] != null ? json['open_now'] : false,
      weekday_text: json['weekday_text'] != null
          ? (json['weekday_text'] as List).cast<String>()
          : <String>[],
      periods: json['periods'] != null
          ? json['periods'].map<Periods>((i) => Periods.fromJson(i)).toList()
          : <Periods>[],
    );
  }
}
