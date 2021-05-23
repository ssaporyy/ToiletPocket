// import 'package:ToiletPocket/searchbar.dart';
import 'package:ToiletPocket/map.dart';
import 'package:ToiletPocket/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:ToiletPocket/map.dart';
import 'package:provider/provider.dart';
// import 'package:search_map_place/search_map_place.dart';
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
        // theme: ThemeData(
        //   primarySwatch: Colors.amber,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: MapSample(),
        // home: SearchBar(),
        // home: MapSample(),

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
//           // Within the FirstScreen widget
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

// // SearchMapPlaceWidget(
// //         hasClearButton: true,
// //         placeType: PlaceType.address,
// //         placeholder: 'Enter the location',
// //         apiKey: 'AIzaSyBVD2yzT1wdbqgnVL_hJ8DWzLlLE24M5Z0',
// //         onSelected: (Place place) async {
// //           Geolocation geolocation = await place.geolocation;
// //           _googleMapController.animateCamera(
// //             CameraUpdate.newLatLng(geolocation.coordinates));
// //           _googleMapController.animateCamera(
// //             CameraUpdate.newLatLngBounds(geolocation.bounds, 0));

// //         },
// //       ),

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false, title: 'Flutter', home: Test());
//   }
// }

// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   GoogleMapController mapController;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       // resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//       SearchMapPlaceWidget(
//         hasClearButton: true,
//         placeType: PlaceType.address,
//         placeholder: 'Enter the location',
//         apiKey: 'AIzaSyAvRknAjBrBfPCXrBTeNYJ8j8g6Fq32frQ',
//         onSelected: (Place place) async {
//           Geolocation geolocation = await place.geolocation;
//           mapController.animateCamera(
//             CameraUpdate.newLatLng(geolocation.coordinates));
//           mapController.animateCamera(
//             CameraUpdate.newLatLngBounds(geolocation.bounds, 0));

//         },
//       ),
//             Padding(
//               padding: const EdgeInsets.only(top: 15.0),
//               child: SizedBox(
//                 height: 500.0,
//                 child: GoogleMap(
//                   onMapCreated: (GoogleMapController googleMapController) {
//                     setState(() {
//                       mapController = googleMapController;
//                     });
//                   },
//                   initialCameraPosition: CameraPosition(
//                     zoom: 15.0,
//                     target: LatLng(13.7650836, 100.5379664)

//                     ),
//                     mapType: MapType.normal,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }