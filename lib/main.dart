import 'package:ToiletPocket/application_bloc.dart';
import 'package:ToiletPocket/homepage.dart';
import 'package:ToiletPocket/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:ToiletPocket/map.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(
  //   MaterialApp(
  //    home: FirstScreen(),
  //   ),
  // );
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
        initialRoute: '/one',
        routes: {
        //   // When navigating to the "/" route, build the FirstScreen widget.
          // '/': (context) => MapSample(),
          '/one': (context) => FirstScreen(),
        //   // When navigating to the "/second" route, build the SecondScreen widget.
          '//': (context) => HomePage(),
        //   '/third': (context) => SearchBar(),
        },
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/welcome.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 100, top: 150),
              child: Text(
                'ยินดีต้อนรับ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 100, top: 0),
              child: Text(
                'Toilet Pocket',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              width: 30,
              height: 40,
              margin: EdgeInsets.only(left: 100, right: 150),
              child: ElevatedButton(
                // Within the `FirstScreen` widget
                child: Text(
                  'เริ่มต้น',
                  style: TextStyle(
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  ),
                ),
                onPressed: () {
                  // Navigate to the second screen using a named route.
                  Navigator.pushNamed(context, '//');
                }, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Second Screen"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           // Within the SecondScreen widget
//           onPressed: () {
//             // Navigate back to the first screen by popping the current route
//             // off the stack.
//             Navigator.pop(context);
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
