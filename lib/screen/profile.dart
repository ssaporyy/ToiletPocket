import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';

  Widget profile(BuildContext context) {
    return Material(
        child: Stack(children: <Widget>[
      Align(
        child: Image.asset(
          'images/Profile.png',
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 25,left: 15),
        child: Column(
          children: [
        TextButton(
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
              Icon(Icons.arrow_back_ios_rounded, size: 18,color: Colors.black87,),
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
      Container(
          // padding: EdgeInsets.only(top: 100, left: 25),
          child: ListTile(
            title: Text('Watanabe Haruto (하루토)',style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  fontWeight: FontWeight.w700,
                ),),
            subtitle: Text('Haruto@hotmail.com',style: TextStyle(
                  color: ToiletColors.colorText,
                  fontSize: 16.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                ),),
          )),
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 55,top: 15),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(blurRadius: 11, color: Colors.white, spreadRadius: 6)
              ],
            ),
            child: CircleAvatar(
              radius: 55.0,
              backgroundImage: 
                      // NetworkImage(_googleSignIn.currentUser.photoUrl),
              // NetworkImage(
              //     'https://pbs.twimg.com/media/E1zDPp6VIAIna9y?format=jpg&name=large'
              //     ),
              AssetImage('images/ruto.jpg'),
            ),
          ),
        ]),
      ),
      Container(
       padding: EdgeInsets.only(top: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 11, color: Colors.black12, spreadRadius: 2)
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 33,
                  color: ToiletColors.colorbottonName,
                ),
                width: 60,
                height: 60,
              ),
              title: Text('ชื่อ',style: TextStyle(
                    color: ToiletColors.colorText,
                    fontSize: 13.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),),
              subtitle: Text('Watanabe Haruto (하루토)',style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 19.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w600,
                  ),),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 11, color: Colors.black12, spreadRadius: 2)
                  ],
                ),
                child: Icon(
                  Icons.mail_outline,
                  size: 30,
                  color: ToiletColors.colorbottonMail,
                ),
                width: 60,
                height: 60,
              ),
              title: Text('อีเมล',style: TextStyle(
                    color: ToiletColors.colorText,
                    fontSize: 13.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),),
              subtitle: Text('Haruto@hotmail.com',style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 19.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w600,
                  ),),
            ),
            //มือถือ ดึงไม่ได้อยู่แล้ว
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 11, color: Colors.black12, spreadRadius: 2)
                  ],
                ),
                child: Icon(
                  Icons.phone_iphone,
                  size: 33,
                  color: ToiletColors.colorbottonPhone,
                ),
                width: 60,
                height: 60,
              ),
              title: Text('มือถือ',style: TextStyle(
                    color: ToiletColors.colorText,
                    fontSize: 13.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),),
              subtitle: Text('+66 2-555-2321',style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 19.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w600,
                  ),),
            ),
            //เพศ ก็ดึงไม่ได้จ้า
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 11, color: Colors.black12, spreadRadius: 2)
                  ],
                ),
                child: Icon(
                  Icons.transgender,
                  size: 28,
                  color: ToiletColors.colorbottonGender,
                ),
                width: 60,
                height: 60,
              ),
             title: Text('เพศ',style: TextStyle(
                    color: ToiletColors.colorText,
                    fontSize: 13.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),),
              subtitle: Text('ชาย',style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 19.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w600,
                  ),),
            ),
          ],
        ),
      ),
          ],
        ),
      )

    ]));
  }

