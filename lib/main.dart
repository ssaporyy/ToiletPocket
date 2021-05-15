// import 'package:ToiletPocket/searchbar.dart';
import 'package:ToiletPocket/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:ToiletPocket/map.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';


void main() {
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
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        // home: SearchBar(),

        // initialRoute: '/',
        // routes: {
        //   // When navigating to the "/" route, build the FirstScreen widget.
        //   '/': (context) => MapSample(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          // '/second': (context) => (),
          // 'third': (context) => SearchBar(),
        // },
      ),
    );
  }
}

// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // title: Text('Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           // Within the `FirstScreen` widget
//           onPressed: () {
//             // Navigate to the second screen using a named route.
//             Navigator.pushNamed(context, '/second');
//           },
//           child: Text('Launch screen'),
//         ),
//       ),
//     );
//   }
// }

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
