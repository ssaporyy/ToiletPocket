import 'package:ToiletPocket/addComment/addImgcomment.dart';
import 'package:ToiletPocket/addToilet_InMap/addImage.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/addToilet_InMap/customRadio.dart';
import 'package:ToiletPocket/addToilet_InMap/iconSelect.dart';
import 'package:ToiletPocket/star.dart';
import 'package:ToiletPocket/addToilet_InMap/time.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class AddComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        // decoration: BoxDecoration(color: ToiletColors.colorBackground,
        //     image: DecorationImage(alignment: Alignment.topCenter,
        //         image: AssetImage("images/banner.png"), fit: BoxFit.scaleDown)),
        child: Stack(
          children: <Widget>[
            // back(AppBar().preferredSize.height),
            appbar(context),
            // slide(context),
          ],
        ),
      ),
    );
  }
}

Widget appbar(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.blue[50],
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("images/banner.png"),
                  fit: BoxFit.scaleDown)),
        ),
        Container(
          padding: EdgeInsets.only(top: 43.0, left: 30.0, right: 0.0),
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
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 90),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                alignment: Alignment.topCenter, child: addDetail(context)),
          ),
        ),
      ],
    ),
  );
}

@override
Widget addDetail(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  double rating = 3.0;
  return Container(
    padding: EdgeInsets.only(left: 0, top: 20),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "รีวิวและประเมินห้องน้ำ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(verticalDirection: VerticalDirection.down, children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 11, color: Colors.white, spreadRadius: 6)
                  ],
                ),
                child: CircleAvatar(
                  radius: 55.0,
                  backgroundImage:
                      // NetworkImage(_googleSignIn.currentUser.photoUrl),
                      // NetworkImage(
                      //     'https://pbs.twimg.com/media/E1zDPp6VIAIna9y?format=jpg&name=large'
                      //     ),
                      // AssetImage('images/ruto.jpg'),
                      NetworkImage(user == null
                          ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                          : (user.photoURL)),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                // 'Haruto',
                (user == null ? 'My Name' : '${user.displayName} '),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
          //star ดาว
          Container(
              height: 70,
              //ยังไม่ได้แก้ ส่วนนี้เป็นดาวที่ให้เรทติ้งที่อยู่ หน้า star.dart
              child: Star()),
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
              // hack textfield height
              padding: EdgeInsets.only(bottom: 0.0),
              child: Flexible(
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "แสดงความคิดเห็น",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        fontWeight: FontWeight.w500,
                        color: Colors.black45),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: addPhotocomment(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 20),
            child: confirm(context),
          ),
          // SizedBox(height: 50,),
        ],
      ),
    ),
  );
}

Widget addPhotocomment(BuildContext context) {
  return Container(
    color: Colors.white,
    alignment: Alignment.topLeft,
    child: Container(
      height: 165,
      width: 280,
      child: Addimgcomment(),
      alignment: Alignment.topLeft,
    ),
  );
}

Widget confirm(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 0),
    width: 120,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
          side: BorderSide(color: ToiletColors.colorButton2)),
      onPressed: () {
        //ยืนยัน
        Navigator.pushNamed(context, '/two');
      },
      padding: EdgeInsets.all(10.0),
      color: ToiletColors.colorButton2,
      textColor: Colors.white,
      child: Text(
        "ยืนยัน",
        style: TextStyle(
          color: Colors.white,
          // fontWeight: FontWeight.w600,
          fontSize: 15,
          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
        ),
      ),
    ),
  );
}
