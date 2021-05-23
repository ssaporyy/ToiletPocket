// // import 'dart:async';

// // import 'package:ToiletPocket/blocs/application_bloc.dart';
// // import 'package:ToiletPocket/models/place.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:outline_material_icons/outline_material_icons.dart';
// // import 'package:provider/provider.dart';

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   Completer<GoogleMapController> _mapController = Completer();
// //   StreamSubscription locationSubscription;
// //   StreamSubscription boundsSubscription;
// //   final _locationController = TextEditingController();

// //   @override
// //   void initState() {
// //     final applicationBloc =
// //         Provider.of<ApplicationBloc>(context, listen: false);

// //     //Listen for selected Location
// //     locationSubscription =
// //         applicationBloc.selectedLocation.stream.listen((place) {
// //       if (place != null) {
// //         _locationController.text = place.name;
// //         _goToPlace(place);
// //       } else
// //         _locationController.text = "";
// //     });

// //     applicationBloc.bounds.stream.listen((bounds) async {
// //       final GoogleMapController controller = await _mapController.future;
// //       controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
// //     });
// //     super.initState();
// //   }

// //   @override
// //   void dispose() {
// //     final applicationBloc =
// //         Provider.of<ApplicationBloc>(context, listen: false);
// //     applicationBloc.dispose();
// //     _locationController.dispose();
// //     locationSubscription.cancel();
// //     boundsSubscription.cancel();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final applicationBloc = Provider.of<ApplicationBloc>(context);
// //     return Scaffold(
// //       body: (applicationBloc.currentLocation == null)
// //           ? Center(
// //               child: CircularProgressIndicator(),
// //             )
// //           :
// //           ListView(
// //               children: [
// //                 // Padding(
// //                 //   padding: const EdgeInsets.all(8.0),
// //                 //   child: TextField(
// //                 //     controller: _locationController,
// //                 //     textCapitalization: TextCapitalization.words,
// //                 //     decoration: InputDecoration(
// //                 //       hintText: 'Search by City',
// //                 //       suffixIcon: Icon(Icons.search),
// //                 //     ),
// //                 //     onChanged: (value) => applicationBloc.searchPlaces(value),
// //                 //     onTap: () => applicationBloc.clearSelectedLocation(),
// //                 //   ),
// //                 // ),

// //                   Stack(
// //                     children: [

// //                       Container(
// //                         height: 3000.0,
// //                         child: GoogleMap(
// //                           mapType: MapType.normal,
// //                           myLocationEnabled: true,

// //                           myLocationButtonEnabled: true,
// //                           padding: EdgeInsets.only(top: 120.0,right:10.0),
// //                           zoomControlsEnabled: false,

// //                           initialCameraPosition: CameraPosition(
// //                             target: LatLng(
// //                                 applicationBloc.currentLocation.latitude,
// //                                 applicationBloc.currentLocation.longitude),
// //                             zoom: 15,
// //                           ),
// //                           onMapCreated: (GoogleMapController controller) {
// //                             _mapController.complete(controller);
// //                           },
// //                           markers: Set<Marker>.of(applicationBloc.markers),
// //                         ),
// //                       ),
// //                       if (applicationBloc.searchResults != null &&
// //                           applicationBloc.searchResults.length != 0)
// //                         Container(
// //                             height: 300.0,
// //                             width: double.infinity,
// //                             decoration: BoxDecoration(
// //                                 color: Colors.black.withOpacity(.6),
// //                                 backgroundBlendMode: BlendMode.darken)),
// //                       if (applicationBloc.searchResults != null)
// //                         Container(
// //                           height: 300.0,
// //                           child: ListView.builder(
// //                               itemCount: applicationBloc.searchResults.length,
// //                               itemBuilder: (context, index) {
// //                                 return ListTile(
// //                                   title: Text(
// //                                     applicationBloc
// //                                         .searchResults[index].description,
// //                                     style: TextStyle(color: Colors.white),
// //                                   ),
// //                                   onTap: () {
// //                                     applicationBloc.setSelectedLocation(
// //                                         applicationBloc
// //                                             .searchResults[index].plceId);
// //                                   },
// //                                 );
// //                               }),
// //                         ),

// //                       //search bar
// //                       Container(
// //                         margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
// //                         padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
// //                         decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(30),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                   color: Colors.black12,
// //                                   blurRadius: 5.0,
// //                                   spreadRadius: 0.5,
// //                                   offset: Offset(
// //                                     0.7,
// //                                     0.7,
// //                                   ))
// //                             ]),
// //                         child: TextField(
// //                           decoration: InputDecoration(
// //                             hintText: 'ค้นหาห้องน้ำ', /*'Search',*/
// //                             hintStyle: TextStyle(fontSize: 18.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
// //                             icon: Icon(Icons.search,color: Colors.black54,),
// //                             border: InputBorder.none,
// //                             suffixIcon:
// //                             IconButton(
// //                                 // onPressed: () => ,
// //                                 onPressed: () {} ,
// //                                 icon: Icon(Icons.account_circle,size: 35,color: Colors.black54,),
// //                               ),
// //                           ),
// //                           cursorColor: Colors.black87,
// //                           style: TextStyle(height: 1.2,fontSize: 20.0),
// //                           onChanged: (value) => applicationBloc.searchPlaces(value),
// //                           onTap: () => applicationBloc.clearSelectedLocation(),
// //                         ),
// //                       ),

// //                     ],
// //                   ),

// //                   //near filter

// //                   //  SizedBox(
// //                   //   height: 20.0,
// //                   // ),
// //                   // Padding(
// //                   //   padding: const EdgeInsets.all(8.0),
// //                   //   child: Text('Find Nearest',
// //                   //       style: TextStyle(
// //                   //           fontSize: 25.0, fontWeight: FontWeight.bold)),
// //                   // ),
// //                   // Padding(
// //                   //   padding: const EdgeInsets.all(8.0),
// //                   //   child: Wrap(
// //                   //     spacing: 8.0,
// //                   //     children: [
// //                   //       FilterChip(
// //                   //         label: Text('Campground'),
// //                   //         onSelected: (val) => applicationBloc.togglePlaceType(
// //                   //             'campground', val),
// //                   //         selected:
// //                   //             applicationBloc.placeType  =='campground',
// //                   //         selectedColor: Colors.blue,
// //                   //       ),
// //                   //       FilterChip(
// //                   //           label: Text('Locksmith'),
// //                   //           onSelected: (val) => applicationBloc
// //                   //               .togglePlaceType('locksmith', val),
// //                   //           selected: applicationBloc.placeType  =='locksmith',
// //                   //           selectedColor: Colors.blue),
// //                   //       FilterChip(
// //                   //           label: Text('Pharmacy'),
// //                   //           onSelected: (val) => applicationBloc
// //                   //               .togglePlaceType('pharmacy', val),
// //                   //           selected:
// //                   //           applicationBloc.placeType  =='pharmacy',
// //                   //           selectedColor: Colors.blue),
// //                   //       FilterChip(
// //                   //           label: Text('Pet Store'),
// //                   //           onSelected: (val) => applicationBloc
// //                   //               .togglePlaceType('pet_store', val),
// //                   //           selected: applicationBloc.placeType  =='pet_store',
// //                   //           selectedColor: Colors.blue),
// //                   //       FilterChip(
// //                   //           label: Text('Lawyer'),
// //                   //           onSelected: (val) =>
// //                   //               applicationBloc
// //                   //                   .togglePlaceType('lawyer', val),
// //                   //           selected:
// //                   //           applicationBloc.placeType  =='lawyer',
// //                   //           selectedColor: Colors.blue),
// //                   //       FilterChip(
// //                   //           label: Text('Bank'),
// //                   //           onSelected: (val) =>
// //                   //               applicationBloc
// //                   //                   .togglePlaceType('bank', val),
// //                   //           selected:
// //                   //           applicationBloc.placeType  =='bank',
// //                   //           selectedColor: Colors.blue),

// //                       ],
// //                     ),
// //                   // )

// //               );
// //   }

// //   Future<void> _goToPlace(Place place) async {
// //     final GoogleMapController controller = await _mapController.future;
// //     controller.animateCamera(
// //       CameraUpdate.newCameraPosition(
// //         CameraPosition(
// //             target: LatLng(
// //                 place.geometry.location.lat, place.geometry.location.lng),
// //             zoom: 14.0),
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';

// import 'package:ToiletPocket/blocs/application_bloc.dart';
// import 'package:ToiletPocket/models/place.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// // import 'package:outline_material_icons/outline_material_icons.dart';
// import 'package:provider/provider.dart';
// // import 'package:search_map_place/search_map_place.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Completer<GoogleMapController> _mapController = Completer();
//   StreamSubscription locationSubscription;
//   StreamSubscription boundsSubscription;
//   final _locationController = TextEditingController();
//   GoogleMapController _googleMapController;
//   LocationData currentLocation;


//   Future<LocationData> getCurrentLocation() async {
//   Location location = Location();
//   try {
//     return await location.getLocation();
//   } on PlatformException catch (e) {
//     if (e.code == 'PERMISSION_DENIED') {
//       // Permission denied
//     }
//     return null;
//   }
// }
//     Future _goToMe() async {
//     final GoogleMapController controller = await _googleMapController;
//     currentLocation = await getCurrentLocation();
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: LatLng(currentLocation.latitude, currentLocation.longitude),
//       zoom: 16,
//     )));
//   }

//   @override
//   void initState() {
//     final applicationBloc =
//         Provider.of<ApplicationBloc>(context, listen: false);

//     //Listen for selected Location
//     locationSubscription =
//         applicationBloc.selectedLocation.stream.listen((place) {
//       if (place != null) {
//         _locationController.text = place.name;
//         _goToPlace(place);
//       } else
//         _locationController.text = "";
//     });

//     applicationBloc.bounds.stream.listen((bounds) async {
//       final GoogleMapController controller = await _mapController.future;
//       controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     final applicationBloc =
//         Provider.of<ApplicationBloc>(context, listen: false);
//     applicationBloc.dispose();
//     _locationController.dispose();
//     locationSubscription.cancel();
//     boundsSubscription.cancel();
//     _googleMapController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final applicationBloc = Provider.of<ApplicationBloc>(context);
//     return Scaffold(
//       body: (applicationBloc.currentLocation == null)
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           :
//           // ListView(
//           //     children: [
//           //       Padding(
//           //         padding: const EdgeInsets.all(8.0),
//           //         child: TextField(
//           //           textInputAction: TextInputAction.search,
//           //           controller: _locationController,
//           //           textCapitalization: TextCapitalization.words,
//           //           decoration: InputDecoration(
//           //             hintText: 'Search by City',
//           //             suffixIcon: Icon(Icons.search),
//           //           ),
//           //           onChanged: (value) => applicationBloc.searchPlaces(value),
//           //           onTap: () => applicationBloc.clearSelectedLocation(),
//           //         ),
//           //       ),

//           Stack(
//               children: [
//                 Container(
//                   height: 3000.0,
//                   child: GoogleMap(
//                     mapType: MapType.normal,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     padding: EdgeInsets.only(top: 120.0, right: 10.0),
//                     zoomControlsEnabled: false,
//                     initialCameraPosition: CameraPosition(
//                       target: LatLng(applicationBloc.currentLocation.latitude,
//                           applicationBloc.currentLocation.longitude),
//                       zoom: 15,
//                     ),
//                     onMapCreated: (GoogleMapController controller) {
//                       _mapController.complete(controller);
//                     },
//                     markers: Set<Marker>.of(applicationBloc.markers),
//                   ),
//                 ),
//                 if (applicationBloc.searchResults != null &&
//                     applicationBloc.searchResults.length != 0)
//                   Container(
//                       height: 300.0,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(.6),
//                           backgroundBlendMode: BlendMode.darken)),
//                 if (applicationBloc.searchResults != null)
//                   Container(
//                     height: 300.0,
//                     child: ListView.builder(
//                         itemCount: applicationBloc.searchResults.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(
//                               applicationBloc.searchResults[index].description,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             onTap: () {
//                               applicationBloc.setSelectedLocation(
//                                   applicationBloc.searchResults[index].plceId);
//                             },
//                           );
//                         }),
//                   ),

//                 //button current location
//                 Container(
//                   color: Colors.transparent,
//                   margin: EdgeInsets.all(15),
//                   padding: const EdgeInsets.fromLTRB(
//                       310 /*left*/, 110 /*top*/, 0 /*right*/, 0 /*bottom*/),
//                   child: FloatingActionButton(
//                     backgroundColor: Colors.white.withOpacity(0.8),
//                     //Theme.of(context).primaryColorLight,
//                     foregroundColor: Colors.black,
//                     onPressed: _goToMe,
//                     child: Icon(
//                       Icons.my_location,
//                       size: 20,
//                     ),
//                   ),
//                 ),

//                 //search bar
//                 Container(
//                   margin: EdgeInsets.only(top: 60.0, left: 15.0, right: 15.0),
//                   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 1),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 5.0,
//                             spreadRadius: 0.5,
//                             offset: Offset(
//                               0.7,
//                               0.7,
//                             ))
//                       ]),
//                   child: TextField(
//                     controller: _locationController,
//                     textCapitalization: TextCapitalization.words,
//                     textInputAction: TextInputAction.search,
//                     decoration: InputDecoration(
//                       hintText: 'ค้นหาห้องน้ำ',
//                       /*'Search',*/
//                       hintStyle: TextStyle(
//                       fontSize: 18.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
//                       icon: Icon(
//                         Icons.search,
//                         color: Colors.black54,
//                       ),
//                       border: InputBorder.none,
//                       suffixIcon: IconButton(
//                         // onPressed: () => ,
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.account_circle,
//                           size: 35,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ),
//                     cursorColor: Colors.black87,
//                     style: TextStyle(height: 1.2, fontSize: 20.0),
//                     onChanged: (value) => applicationBloc.searchPlaces(value),
//                     onTap: () => applicationBloc.clearSelectedLocation(),
//                   ),
//                 ),
                
//               ],
//             ),

//       //near filter

//       //  SizedBox(
//       //   height: 20.0,
//       // ),
//       // Padding(
//       //   padding: const EdgeInsets.all(8.0),
//       //   child: Text('Find Nearest',
//       //       style: TextStyle(
//       //           fontSize: 25.0, fontWeight: FontWeight.bold)),
//       // ),
//       // Padding(
//       //   padding: const EdgeInsets.all(8.0),
//       //   child: Wrap(
//       //     spacing: 8.0,
//       //     children: [
//       //       FilterChip(
//       //         label: Text('Campground'),
//       //         onSelected: (val) => applicationBloc.togglePlaceType(
//       //             'campground', val),
//       //         selected:
//       //             applicationBloc.placeType  =='campground',
//       //         selectedColor: Colors.blue,
//       //       ),
//       //       FilterChip(
//       //           label: Text('Locksmith'),
//       //           onSelected: (val) => applicationBloc
//       //               .togglePlaceType('locksmith', val),
//       //           selected: applicationBloc.placeType  =='locksmith',
//       //           selectedColor: Colors.blue),
//       //       FilterChip(
//       //           label: Text('Pharmacy'),
//       //           onSelected: (val) => applicationBloc
//       //               .togglePlaceType('pharmacy', val),
//       //           selected:
//       //           applicationBloc.placeType  =='pharmacy',
//       //           selectedColor: Colors.blue),
//       //       FilterChip(
//       //           label: Text('Pet Store'),
//       //           onSelected: (val) => applicationBloc
//       //               .togglePlaceType('pet_store', val),
//       //           selected: applicationBloc.placeType  =='pet_store',
//       //           selectedColor: Colors.blue),
//       //       FilterChip(
//       //           label: Text('Lawyer'),
//       //           onSelected: (val) =>
//       //               applicationBloc
//       //                   .togglePlaceType('lawyer', val),
//       //           selected:
//       //           applicationBloc.placeType  =='lawyer',
//       //           selectedColor: Colors.blue),
//       //       FilterChip(
//       //           label: Text('Bank'),
//       //           onSelected: (val) =>
//       //               applicationBloc
//       //                   .togglePlaceType('bank', val),
//       //           selected:
//       //           applicationBloc.placeType  =='bank',
//       //           selectedColor: Colors.blue),
//       //   ],
//       // ),
//       // )
//     // );



//               // ]
//               // )
              
//               );
//   }

//   Future<void> _goToPlace(Place place) async {
//     final GoogleMapController controller = await _mapController.future;
//     controller.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//             target: LatLng(
//                 place.geometry.location.lat, place.geometry.location.lng),
//             zoom: 14.0),
//       ),
//     );
//   }
// }
