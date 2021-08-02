import 'package:flutter/material.dart';

class Timeselect extends StatefulWidget {
  @override
  _TimeselectState createState() => _TimeselectState();
}

class _TimeselectState extends State<Timeselect> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        // print(_time);
        if (_time == newTime) {
          debugPrint('TimeOfOpen: $_time');
        }
      });
    }
  }
  void _selectTime2() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        // print(_time);
        if (_time == newTime) {
          debugPrint('TimeOfClosed: $_time');
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RaisedButton(
            elevation: 0,
            color: Colors.white,
            onPressed: _selectTime,
            padding: EdgeInsets.all(0.0),
            child: Row(
              children: [
                Text(
                  "เปิดเมื่อ  ${_time.format(context)}",
                  style: TextStyle(
                    color: Colors.red,
                    // fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[900],
                  size: 20,
                )
              ],
            ),
          ),
          SizedBox(
            width: 13,
          ),
          RaisedButton(
            elevation: 0,
            color: Colors.white,
            onPressed: _selectTime2,
            padding: EdgeInsets.all(0.0),
            child: Row(
              children: [
                Text(
                  "ปิดเมื่อ  ${_time.format(context)}",
                  style: TextStyle(
                    color: Colors.red,
                    // fontWeight: FontWeight.w600,
                    fontSize: 13,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey[900],
                  size: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
