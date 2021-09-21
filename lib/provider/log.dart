import 'package:ToiletPocket/screen/firstScreen.dart';
import 'package:ToiletPocket/screen/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Profile();
            } else if (snapshot.hasError) {
              return Center(child: Text('Somthing Went Wrong!'));
            } else {
              return FirstScreen();
            }
          },
        ),
      );
}
