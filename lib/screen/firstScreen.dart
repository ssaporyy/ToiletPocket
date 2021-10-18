import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/screen/homepage.dart';
// import 'package:ToiletPocket/screen/profile.dart';
import 'package:ToiletPocket/screen/showUp.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:rive/rive.dart';

class FirstScreen extends StatefulWidget {
  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    int delayAmount = 3500;
    return Material(
        child: Stack(children: <Widget>[
      Align(
        child: RiveAnimation.asset(
          'images/login.riv',
          fit: BoxFit.fill,
        ),
      ),
      ShowUp(
        delay: delayAmount,
        child: Align(
          child: ListView(
            children: [
              Container(
                height: 65,
                margin: EdgeInsets.only(left: 50, top: 126),
                child: Text(
                  'ยินดีต้อนรับ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Sukhumvit',
                    color: Colors.black,
                    fontSize: 55,
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(left: 50, top: 0),
                child: Text(
                  'Toilet Pocket',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Sukhumvit',
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
              SizedBox(
                height: 13,
              ),
              Container(
                width: 20,
                height: 45,
                margin: EdgeInsets.only(left: 50, right: 200),
                child: ElevatedButton(
                  // Within the `FirstScreen` widget
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ToiletColors.colorButton2,
                      elevation: 5.0),

                  child: Text(
                    'เริ่มต้น',
                    style: TextStyle(
                        fontFamily: 'Sukhumvit', fontSize: 20),
                  ),
                  onPressed: () {
                    // Navigate to the second screen using a named route.

                    // Navigator.pushNamed(context, '/two');

                     final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.signInAnonymously();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      ShowUp(
        delay: delayAmount + 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 48,
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontFamily: 'Sukhumvit',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'เข้าสู่ระบบได้ง่ายขึ้น',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 11.0,
                fontFamily: 'Sukhumvit',
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Opacity(
              opacity: 0.7,
              child: Container(
                width: 250,
                height: 45,
                color: Colors.transparent,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.login();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  },
                  label: Text('Continue with Google',
                      style: TextStyle(
                        color: ToiletColors.colorButton2,
                        fontSize: 16,
                        fontFamily: 'Sukhumvit',
                        fontWeight: FontWeight.w700,
                      )),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // <-- Radius
                      ),
                      primary: Colors.white.withOpacity(0.7),
                      shadowColor: Colors.white,
                      elevation: 7.0),
                  icon: Image.asset(
                    'images/google.png',
                    height: 40,
                    width: 35,
                  ),
                ),
              ),
            ),
            Container(
              height: 28,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'คุณยังไม่มีบัญชี?',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.0,
                      fontFamily: 'Sukhumvit',
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 38,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        primary: Colors.black,
                        padding: EdgeInsets.all(5),
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                          fontFamily: 'Sukhumvit',
                        ),
                      ),
                      onPressed: () {
                        //กดแล้วไปสร้างบัญชีกูเกิ้ล
                      },
                      child: const Text('สร้าง'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ]));
  }
}
