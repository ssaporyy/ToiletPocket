import 'package:ToiletPocket/models/sub_periods.dart';

class Periods {
  final SubPeriods close;
  final SubPeriods open;

  Periods({this.close, this.open});

  factory Periods.fromJson(Map<String, dynamic> json) {
    return Periods(
      close: json['close'] != null ? SubPeriods.fromJson(json['close']) : null,
      open: json['open'] != null ? SubPeriods.fromJson(json['open']) : null,
    );
  }
}
