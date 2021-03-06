import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/screen/firstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Material(
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
          padding: EdgeInsets.only(top: 25, left: 15),
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
              Container(
                  child: ListTile(
                title: Text(
                  (user == null|| user.isAnonymous ? 'My Name' : '${user.displayName} '),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  (user == null|| user.isAnonymous ? 'My Email' : '${user.email} '),
                  style: TextStyle(
                    color: ToiletColors.colorText,
                    fontSize: 16.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),
                ),
              )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 55, top: 15),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 11,
                            color: Colors.white,
                            spreadRadius: 6)
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: ToiletColors.colorButton,
                      radius: 55.0,
                      backgroundImage: NetworkImage(user == null|| user.isAnonymous
                          ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                          : (user.photoURL)),
                    ),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.only(top: 80),
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
                                blurRadius: 11,
                                color: Colors.black12,
                                spreadRadius: 2)
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
                      title: Text(
                        'ชื่อ',
                        style: TextStyle(
                          color: ToiletColors.colorText,
                          fontSize: 13.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                      subtitle: Text(
                        (user == null|| user.isAnonymous ? 'My Name' : '${user.displayName} '),
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 19.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 11,
                                color: Colors.black12,
                                spreadRadius: 2)
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
                      title: Text(
                        'อีเมล',
                        style: TextStyle(
                          color: ToiletColors.colorText,
                          fontSize: 13.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                      subtitle: Text(
                        (user == null|| user.isAnonymous ? 'My Email' : '${user.email} '),
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 19.0,
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    //ปุ่ม logout
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(top: 60, right: 20),
                      child: SizedBox(
                        height: 45,
                        width: 120,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ToiletColors.colorPurple),
                          ),
                          child: Text(
                            (user == null|| user.isAnonymous ? 'Sign in' : 'Sign Out'),
                            // 'Sign Out',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            if (user == null) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return FirstScreen();
                              }));
                            } else if(user != null){
                              provider.logout();
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return FirstScreen();
                              }));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ])),
    );
  }
}
