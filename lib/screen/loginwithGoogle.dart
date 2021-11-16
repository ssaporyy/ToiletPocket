import 'package:ToiletPocket/addToilet_InMap/addToiletDetail.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/screen/showUp.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginGoogle extends StatefulWidget {
  @override
  LoginGoogleState createState() => LoginGoogleState();
}

class LoginGoogleState extends State<LoginGoogle> {
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
    final currentPosition = Provider.of<Position>(context);
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
      ShowUp(
        delay: delayAmount,
        child: Align(
          child: ListView(
            children: [
              Container(
                height: 75,
                margin: EdgeInsets.only(left: 43, top: 126),
                child: Text(
                  'Toilet Pocket',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    color: Colors.black,
                    fontSize: 55,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 110,
                margin: EdgeInsets.only(left: 50, top: 0),
                child: Text(
                  'Sign in with\nGoogle',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      height: 1.3),
                ),
              ),
              SizedBox(
                height: 13,
              ),
            ],
          ),
        ),
      ),
      ShowUp(
        delay: delayAmount + 50,
        child: Container(
          padding: EdgeInsets.only(top: 230),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 51),
                child: Opacity(
                  opacity: 0.9,
                  child: Container(
                    width: 250,
                    height: 45,
                    color: Colors.transparent,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.login();
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return AddToiletDetail();
                        // }));
                        Navigator.pushNamed(
                          context,
                          '/six',
                          arguments: {'currentlocation': currentPosition},
                        );
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
                            borderRadius:
                                BorderRadius.circular(5), // <-- Radius
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
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 28,
                padding: EdgeInsets.only(left: 51),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'คุณยังไม่มีบัญชี?',
                      style: TextStyle(
                        color: Colors.black54,
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
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          ),
                        ),
                        // onPressed: () {
                        //   //กดแล้วไปสร้างบัญชีกูเกิ้ล
                        //   // final provider = Provider.of<GoogleSignInProvider>(
                        //   //     context,
                        //   //     listen: false);
                        //   // provider.login();
                        //   // Navigator.pushReplacement(context,
                        //   //     MaterialPageRoute(builder: (context) {
                        //   //   return HomePage();
                        //   // }));
                        //   const url = 'https://google.com';
                        //   // launchURL(url);
                        //   launch(url, forceWebView: true);
                        // },
                        onPressed: _launchURLApp,
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
      ),
    ]));
  }
}
