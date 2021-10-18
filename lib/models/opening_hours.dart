// import 'dart:convert';

import 'package:ToiletPocket/models/periods.dart';
// import 'package:flutter/foundation.dart';

class OpeningHours {
  final bool? openNow;
  final List<String>? weekdayText;
  final List<Periods>? periods;
  OpeningHours({
    this.openNow,
    this.weekdayText,
    this.periods,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json['open_now'] != null ? json['open_now'] : false,
      weekdayText: json['weekday_text'] != null
          ? (json['weekday_text'] as List).cast<String>()
          : <String>[],
      periods: json['periods'] != null
          ? json['periods'].map<Periods>((i) => Periods.fromJson(i)).toList()
          : <Periods>[],
    );
  }
}
