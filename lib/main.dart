// import 'package:ToiletPocket/addToilet.dart';
import 'package:ToiletPocket/Show_toiletDetail_review/toiletdetail.dart';
import 'package:ToiletPocket/addToilet_InMap/addToilet.dart';
import 'package:ToiletPocket/addToilet_InMap/addToiletDetail.dart';
import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/blocs/application_bloc2.dart';
import 'package:ToiletPocket/screen/firstScreen.dart';
import 'package:ToiletPocket/screen/home_screen.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/screen/profile.dart';
import 'package:ToiletPocket/screen/search.dart';
// import 'package:ToiletPocket/homepage.dart';
// import 'package:ToiletPocket/profile.dart';
// import 'package:ToiletPocket/toiletdetail.dart';
// import 'package:toiletpocket/searchbar.dart';
import 'package:flutter/material.dart';
// import 'package:toiletpocket/map.dart';
import 'package:provider/provider.dart';

void main() {
// runApp(
// MaterialApp(
// home: FirstScreen(),
// ),
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
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Toilet Pocket',
// Start the app with the "/" named route. In this case, the app starts

// on the FirstScreen widget.
        initialRoute: '/two',
        routes: {
// // When navigating to the "/" route, build the FirstScreen widget.
          '/one': (context) => FirstScreen(),
// // When navigating to the "/second" route, build the SecondScreen widget.
          '/two': (context) => Homeonescreen(),
          '/third': (context) => ToiletDetail(),
          '/four': (context) => Profile(),
          '/five': (context) => addToilet(),
          '/six': (context) => AddToiletDetail(),
//ตัวนี้ไม่ใช้แล้ว แต่อย่าเพิ่งลบ
          '/1': (context) => HomePage(),
        },
      ),
    );
  }
}
