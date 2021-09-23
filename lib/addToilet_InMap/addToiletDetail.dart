import 'package:ToiletPocket/addToilet_InMap/addImage.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/addToilet_InMap/customRadio.dart';
import 'package:ToiletPocket/addToilet_InMap/iconSelect.dart';
import 'package:ToiletPocket/star.dart';
import 'package:ToiletPocket/addToilet_InMap/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AddToiletDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: back(context),
      body: Stack(
        children: <Widget>[
          // back(context),
          appbar(context),
          // slide(context),
        ],
      ),
    );
  }
}

Widget appbar(BuildContext context) {
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

  return MaterialApp(
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
        child: Align(alignment: Alignment.topCenter, child: addDetail(context)),
      ),
    ),
  );
}

@override
Widget addDetail(BuildContext context) {
  double rating = 3.0;
  return Container(
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
              height: 10,
            ),
            Container(
                height: 80,
                //ยังไม่ได้แก้ ส่วนนี้เป็นดาวที่ให้เรทติ้งที่อยู่ หน้า star.dart
                child: MyHomePage()),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 3),
              child: ToiletLocation(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 3),
              child: time(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: info(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 5),
              child: addPhoto(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 5),
              child: payment(context),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: confirm(),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
  );
}

Widget ToiletLocation(BuildContext context) {
  return Container(
    alignment: Alignment.centerLeft,
    child: ListTile(
      leading: Icon(
        OMIcons.locationOn,
        color: ToiletColors.colorPurple,
        size: 36.0,
      ),
      title: Text(
        '126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140',
        style: TextStyle(
          color: Colors.black,
          fontSize: 11.0,
          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget time(BuildContext context) {
  return Container(
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
        child: Timeselect(),
      ),
    ),
  );
}

Widget info(BuildContext context) {
  return Container(
    height: 100,
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(
          OMIcons.info,
          color: ToiletColors.colorPurple,
          size: 29.0,
        ),
        title: Container(height: 150, child: SelectIcon()),
      ));
}

Widget addPhoto(BuildContext context) {
  return Container(
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
  );
}

Widget payment(BuildContext context) {
  return Container(
    color: Colors.white,
    alignment: Alignment.centerLeft,
    child: ListTile(
      leading: Icon(
        Icons.local_atm,
        color: ToiletColors.colorPurple,
        size: 30.0,
      ),
      title: Container(
        child: customRadio(),
      ),
    ),
  );
}

Widget confirm() {
  return Container(
    margin: EdgeInsets.only(top: 20),
    width: 250,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: ToiletColors.colorButton2)),
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
  );
}
