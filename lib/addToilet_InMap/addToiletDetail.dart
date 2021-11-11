import 'package:ToiletPocket/addToilet_InMap/addImage.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/star2.dart';
// import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';


class AddToiletDetail extends StatefulWidget {
  const AddToiletDetail({Key key}) : super(key: key);

  final String title = 'Wrap Widget & Chips';

  @override
  _AddToiletDetailState createState() => _AddToiletDetailState();
}

class Company {
  const Company(this.name);
  final String name;
}

class _AddToiletDetailState extends State<AddToiletDetail> {

  // final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // final fromKey = GlobalKey<FormState>();
  // CollectionReference addToilets = FirebaseFirestore.instance.collection('AddToilets');

  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  TimeOfDay _time2 = TimeOfDay(hour: 0, minute: 00);

  List<String> lst = ['ไม่เสียค่าใช้บริการ', 'เสียค่าใช้บริการ'];
  int selectedIndex = 0;

  List<IconData> iconList = [
    Icons.settings,
    Icons.bookmark,
    Icons.account_circle
  ];
  int secondaryIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
        // print(_time);
        if (_time2 == newTime) {
          debugPrint('TimeOfClosed: $_time2');
        }
      });
    }
  }

  List<Company> _companies;
  List<String> _filters;

  @override
  void initState() {
    _filters = <String>[];
    _companies = <Company>[
      //Men’s room
      const Company('ห้องน้ำชาย'),
      //Ladies’ room
      const Company('ห้องน้ำหญิง'),
      //disabled toilet
      const Company('ห้องน้ำสำหรับผู้พิการ'),
      //Smoking Area
      const Company('เขตสูบบุหรี่'),
    ];
    super.initState();
  }

  Iterable<Widget> get companyWidgets sync* {
    for (Company company in _companies) {
      yield Padding(
        padding: const EdgeInsets.only(left: 3),
        child: FilterChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('images/flush.png'),
            // Text(
            //   company.name[0].toUpperCase(),
            //   style: TextStyle(
            //     color: Colors.white,
            //     // fontWeight: FontWeight.w600,
            //     fontSize: 15,
            //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            //   ),
            // ),
          ),
          label: Text(
            company.name,
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.w600,
              fontSize: 10,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            ),
          ),
          selected: _filters.contains(company.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(company.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == company.name;
                });
              }
              print('Selected: ${_filters.join(', ')}');
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double rating = 3.0;
    back(height) => PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height + 180),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 43.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/two');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 18,
                        color: Colors.black87,
                      ),
                      Text(
                        'กลับ',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    return SafeArea(
      child: Scaffold(
        // appBar: back(context),
        body: Stack(
          children: <Widget>[
            // back(context),
            // appbar(context),
            // slide(context),
            MaterialApp(
              home: Scaffold(
                backgroundColor: ToiletColors.colorBackground,
                appBar: back(AppBar().preferredSize.height),
                body: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: ToiletColors.colorBackground
                            .withOpacity(0.9), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 0, top: 25),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "รายละเอียดห้องน้ำ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                height: 80,
                                //ยังไม่ได้แก้ ส่วนนี้เป็นดาวที่ให้เรทติ้งที่อยู่ หน้า star.dart
                                child: Star2()),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 2),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Icon(
                                    OMIcons.locationOn,
                                    color: ToiletColors.colorPurple,
                                    size: 36.0,
                                  ),
                                  title: Text(
                                    // '126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140',
                                    '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 3),
                              child: Container(
                                alignment: Alignment.center,
                                child: ListTile(
                                  leading: Icon(
                                    OMIcons.timer,
                                    color: ToiletColors.colorPurple,
                                    size: 29.0,
                                  ),
                                  title: Container(
                                    alignment: Alignment.topLeft,
                                    height: 50,
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  fontSize: 11,
                                                  fontFamily:
                                                      'Sukhumvit' ?? 'SF-Pro',
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
                                                "ปิดเมื่อ  ${_time2.format(context)}",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 11,
                                                  fontFamily:
                                                      'Sukhumvit' ?? 'SF-Pro',
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
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    leading: Icon(
                                      OMIcons.info,
                                      color: ToiletColors.colorPurple,
                                      size: 29.0,
                                    ),
                                    title: Container(
                                      height: 150,
                                      child: Row(
                                        children: <Widget>[
                                          Wrap(
                                            direction: Axis.vertical,
                                            children: companyWidgets.toList(),
                                          ),
                                          // Text('Selected: ${_filters.join(', ')}'),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 5),
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.topLeft,
                                child: ListTile(
                                    leading: Icon(
                                      OMIcons.collections,
                                      color: ToiletColors.colorPurple,
                                      size: 30.0,
                                    ),
                                    title: Container(
                                      height: 86,
                                      width: 250,
                                      child: addImage(),
                                      alignment: Alignment.topLeft,
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 5),
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.local_atm,
                                    color: ToiletColors.colorPurple,
                                    size: 30.0,
                                  ),
                                  title: Container(
                                    child: Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              showCustomRadio(lst[0], 0),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              showCustomRadio(lst[1], 1),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                width: 250,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color: ToiletColors.colorButton2)),
                                  onPressed: () {
                                    //ยืนยัน
                                  },
                                  padding: EdgeInsets.all(10.0),
                                  color: ToiletColors.colorButton2,
                                  textColor: Colors.white,
                                  child: Text(
                                    "ยืนยัน",
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCustomRadio(String txt, int index) {
    return Container(
      height: 40,
      width: 130,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(
            color:
                selectedIndex == index ? ToiletColors.colorPurple : Colors.grey,
            width: 2),
        child: Text(
          txt,
          style: TextStyle(
              color: selectedIndex == index
                  ? ToiletColors.colorPurple
                  : Colors.grey,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              fontSize: 12),
        ),
      ),
    );
  }
}
