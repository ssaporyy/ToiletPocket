import 'package:ToiletPocket/addImage.dart';
import 'package:ToiletPocket/addToiletDetail.dart';
import 'package:ToiletPocket/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/customRadio.dart';
import 'package:ToiletPocket/customRadio2.dart';
import 'package:ToiletPocket/firstScreen.dart';
import 'package:ToiletPocket/homepage.dart';
import 'package:ToiletPocket/profile.dart';
import 'package:ToiletPocket/provider/google_sign_in.dart';
import 'package:ToiletPocket/showUp.dart';
import 'package:ToiletPocket/signIn.dart';
import 'package:ToiletPocket/time.dart';
import 'package:ToiletPocket/toiletdetail.dart';
import 'package:rive/rive.dart';
// import 'package:toiletpocket/searchbar.dart';
import 'package:flutter/material.dart';
// import 'package:toiletpocket/map.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(
  //   MaterialApp(
  //    home: FirstScreen(),
  //   ),
  // );

  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Applicationbloc(),
      child: MaterialApp(
        title: 'Toilet Pocket',
        // Start the app with the "/" named route. In this case, the app starts
        // on the FirstScreen widget.
        // home: ToiletDetail(),
        // home: FirstScreen(),
        // home: Profile(),
        // home: GoogleSignApp(),
        // home: addToilet(),
        // home: SignInScreen(),
        // home: AddToiletDetail(),
        // home: customRadio2(),
        // home: MyHomePage(),
        // home: addImage(),
        // home: HomePage(),
        initialRoute: '/one',
        routes: {
          //   // When navigating to the "/" route, build the FirstScreen widget.
          // '/': (context) => MapSample(),
          '/one': (context) => FirstScreen(),
          //   // When navigating to the "/second" route, build the SecondScreen widget.
          '/two': (context) => HomePage(),
          '/third': (context) => ToiletDetail(),
          '/four': (context) => Profile(),

        },
      ),
    );
  }
}
