import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/screen/showUp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginGoogleAddcomment extends StatefulWidget {
  @override
  LoginGoogleAddcommentState createState() => LoginGoogleAddcommentState();
}

class LoginGoogleAddcommentState extends State<LoginGoogleAddcomment> {
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLBrowser() async {
    const url = 'https://flutterdevs.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLApp() async {
    const url = 'https://flutterdevs.com/';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // final currentPosition = Provider.of<Position>(context);
    int delayAmount = 1500;
    return Material(
        child: Stack(children: <Widget>[
      Align(
        child: Image.asset(
          'images/signUp.png',
          width: 500,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 43.0, left: 20.0, right: 0.0),
        child: Container(
          padding: EdgeInsets.only(top: 30.0),
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, '/two');
              Navigator.of(context).pop();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
      ),

      Padding(
        padding: const EdgeInsets.only(top: 120),
        child: ShowUp(
          delay: delayAmount,
          child: Align(
            child: ListView(
              children: [
                Container(
                  width: 20,
                  height: 45,
                  margin: EdgeInsets.only(left: 50, right: 230),
                  child: ElevatedButton(
                    // Within the `FirstScreen` widget
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: ToiletColors.colorButton2,
                        elevation: 5.0),

                    child: Text(
                      'Hey,',
                      style: TextStyle(
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro', fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 75,
                  margin: EdgeInsets.only(left: 50, top: 0),
                  child: Text(
                    'Already have',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      color: Colors.black,
                      fontSize: 45,
                    ),
                  ),
                ),
                Container(
                  height: 65,
                  margin: EdgeInsets.only(left: 50, top: 0),
                  child: Text(
                    'an account?',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        color: Colors.black,
                        fontSize: 45,
                        height: 0.8),
                  ),
                ),
              ],
            ),
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
                'Toilet Pocket',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 38.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'เข้าสู่ระบบได้ง่ายขึ้น',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 11.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 30,
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
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
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
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
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
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                      onPressed: () {
                        //กดแล้วไปสร้างบัญชีกูเกิ้ล
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.login();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
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
      // ),
    ]));
  }
}
