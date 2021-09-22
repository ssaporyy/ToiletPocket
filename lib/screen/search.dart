import 'dart:async';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/models/place_response.dart';
import 'package:ToiletPocket/models/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

//
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ToiletPocket/models/error.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _locationController = TextEditingController();

  //
  //   //new
//   BitmapDescriptor pinLocationIcon;
//   Error error;
//   List<Result> places;
//   bool searching = true;
//   String keyword;
//   List<Marker> markers = <Marker>[];
//   static const String baseUrl =
//       "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
//   static const String _API_KEY = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';
//   double lat;
//   double lng;
//     // double lat = applicationBloc.currentLocation.longitude;
//     // double lng = applicationBloc.currentLocation.latitude;
//   // static double latitude = 13.736717;
//   // static double longitude = 100.523186;
// //new
//   void setCustomMapPin() async {
//     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(size: Size(10, 10)), 'images/flush.png');
//   }
//   //
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Column(
      children: [
        Padding(
          //old
          padding: const EdgeInsets.only(top: 0.0),
          //new
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            child: TextField(
              controller: _locationController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'ค้นหาห้องน้ำ',
                /*'Search',*/
                hintStyle: TextStyle(
                    fontSize: 15.0, fontFamily: 'Sukhumvit' ?? 'SF-Pro'),
                icon: Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                border: InputBorder.none,
                suffixIcon: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/four');

                    // searchNearby(lat, lng);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(user == null
                              ?
                              'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                              : (user
                                  .photoURL)), 
                                  // NetworkImage(user.photoURL),
                          // NetworkImage(
                          //     'https://pbs.twimg.com/media/E1zDPp6VIAIna9y?format=jpg&name=large'),
                          // AssetImage('images/ruto.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onChanged: (value) => applicationBloc.searchPlaces(value),
              onTap: () => applicationBloc.clearSelectedLocation(),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (applicationBloc.searchResults != null &&
            applicationBloc.searchResults.length != 0)
          Container(
            height: 300.0,
            decoration: BoxDecoration(
                color: Colors.white,
                // .withOpacity(.6),
                // backgroundBlendMode: BlendMode.darken
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      ))
                ]),
            child: ListView.separated(
              itemCount: applicationBloc.searchResults.length,
              // itemCount: 0,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    applicationBloc
                        // .searchResults[index].name,
                        .searchResults[index]
                        .description,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    applicationBloc.setSelectedLocation(
                        applicationBloc.searchResults[index].placeId);
                    // print(applicationBloc.selectedLocationStatic.geometry.location.lat);
                    // print(applicationBloc.selectedLocationStatic.geometry.location.lng);
                    // searchNearby(applicationBloc.selectedLocationStatic.geometry.location.lat, applicationBloc.selectedLocationStatic.geometry.location.lng);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          )
      ],
    );
  }

// void searchNearby(double lat, double lng) async {
//     final applicationBloc = Provider.of<ApplicationBloc>(context);
//     double lat = applicationBloc.currentLocation.longitude;
//     double lng = applicationBloc.currentLocation.latitude;
//     // static double latitude = applicationBloc.currentLocation.longitude;
//     // static double longitude = applicationBloc.currentLocation.latitude;
//     setState(() {
//       markers.clear();
//     });
//     dynamic /*String */ url =
//         '$baseUrl?key=$_API_KEY&location=$lat,$lng&radius=1500&keyword=toilets';
//     print(url);
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       _handleResponse(data);
//     } else {
//       throw Exception('An error occurred getting places nearby');
//     }

//     // make sure to hide searching
//     setState(() {
//       searching = false;
//     });
//   }

//   void _handleResponse(data) {
//     // bad api key or otherwise
//     if (data['status'] == "REQUEST_DENIED") {
//       setState(() {
//         error = Error.fromJson(data);
//       });
//       // success
//     } else if (data['status'] == "OK") {
//       setState(() {
//         places = PlaceResponse.parseResults(data['results']);
//         for (int i = 0; i < places.length; i++) {
//           markers.add(
//             Marker(
//               markerId: MarkerId(places[i].placeId),
//               // icon: BitmapDescriptor.defaultMarkerWithHue(198.0),
//               icon: pinLocationIcon,
//               position: LatLng(places[i].geometry.location.lat,
//                   places[i].geometry.location.lng),
//               infoWindow: InfoWindow(
//                   title: places[i].name, snippet: places[i].vicinity),
//               onTap: () {},
//             ),
//           );
//         }
//       });
//     } else {
//       print(data);
//     }
//   }

}
