import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class addToilet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ToiletColors.colorButton,
        body: add(context),
      ),
    );
  }
}

Widget add(BuildContext context) {
  return SafeArea(
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 150,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    ToiletColors.colorBackground,
                    ToiletColors.colorPurple2,
                  ],
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    //color of shadow
                    spreadRadius: 3, //spread radius
                    blurRadius: 9, // blur radius
                    offset: Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          alignment: Alignment.center,
                          primary: Colors.black,
                          padding: EdgeInsets.all(5),
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/two');
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 18,
                              color: Colors.blue,
                            ),
                            Text(
                              'กลับ',
                              style: TextStyle(
                                color: Colors.blue,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "เพิ่มตำแหน่งห้องน้ำ",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.w600,
                        fontSize: 25,
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'images/toiletplus_.png',
                      height: 25,
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      //color of shadow
                      spreadRadius: 3, //spread radius
                      blurRadius: 9, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                      //first paramerter of offset is left-right
                      //second parameter is top to down
                    ),
                  ]),
              child: Container(
                margin: EdgeInsets.all(40),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: ToiletColors.colorButton2)),
                  onPressed: () {
                    //ไปหน้าใส่รายละเอียด
                    Navigator.pushNamed(context, '/six');
                  },
                  padding: EdgeInsets.all(10.0),
                  color: ToiletColors.colorButton2,
                  textColor: Colors.white,
                  child: Text(
                    "ยืนยันตำแหน่ง",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    ),
                  ),
                ),
              ),
            )),
      ],
    ),
  );
}
