import 'dart:async';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/models/open.dart';
import 'package:ToiletPocket/models/place_response.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/models/result.dart';
import 'package:ToiletPocket/screen/cardLocation.dart';
import 'package:ToiletPocket/screen/search.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:ToiletPocket/services/marker_service.dart';

//
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ToiletPocket/models/error.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();
  final placesService = PlacesService();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
        // applicationBloc.clearSelectedLocation();
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
    // //new
    // setCustomMapPin();
  }

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

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          zoom: 16.0,
          tilt: 50.0,
        ),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    LocationData _currentPosition;
    var location = new Location();
    try {
      _currentPosition = await location.getLocation();
    } on Exception {
      _currentPosition = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 16.0,
        tilt: 50.0,
      ),
    ));
  }
  // Update the position on CameraMove
//  _onCameraMove(CameraPosition position) {
//    LatLng _lastMapPosition = _center;
// static const LatLng _center = LatLng(currentPosition.latitude,currentPosition.longitude);
//     _lastMapPosition = position.target;
//   }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Places>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //new
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final _place = ModalRoute.of(context)?.settings.arguments as Places;

    return FutureProvider(
      create: (context) => placesProvider,
      child: SafeArea(
        child: Scaffold(
          body: (currentPosition != null)
              ? Consumer<List<Places>>(
                  builder: (_, places, __) {
                    var markers = (places != null)
                        ? markerService.getMarkers(places)
                        : List<Marker>();
                    return (places != null)
                        ? Stack(
                            children: [
                              // Maps(),
                              Container(
                                // height: MediaQuery.of(context).size.height / 2,
                                // height: 500,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(currentPosition.latitude,
                                        currentPosition.longitude),
                                    zoom: 16.0,
                                    tilt: 50.0,
                                    // bearing: 30,
                                  ),
                                  // //new
                                  onCameraMove:
                                      (CameraPosition cameraPosition) {
                                    print(cameraPosition.zoom);
                                  },
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  //เลื่อนปุ่ม current ให้ขึ้นมา
                                  padding: EdgeInsets.only(
                                    bottom: 255.0,
                                  ),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController.complete(controller);
                                  },
                                  markers: Set<Marker>.of(markers),
                                  myLocationButtonEnabled: false,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, bottom: 280),
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 50,
                                      child: ElevatedButton(
                                        // Within the `FirstScreen` widget
                                        style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            primary: Colors.white,
                                            elevation: 5.0),
                                        child: Icon(
                                          Icons.location_on,
                                          color: ToiletColors.colorButtonblue,
                                        ),
                                        onPressed: _currentLocation,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, bottom: 340),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 50,
                                    child: ElevatedButton(
                                      // Within the `FirstScreen` widget
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          primary: Colors.white,
                                          elevation: 5.0),

                                      child: Image.asset(
                                        'images/toiletPlus.png',
                                        fit: BoxFit.cover,
                                        height: 20,
                                      ),
                                      onPressed: () {
                                        // Navigate to the second screen using a named route.
                                        Navigator.pushNamed(context, '/five');
                                      },
                                    ),
                                  ),
                                  // FloatingActionButton(
                                  //     backgroundColor: Colors.blue,
                                  //     onPressed: () {},
                                  //     child: Image.asset(
                                  //       'images/toiletPlus.png',
                                  //       fit: BoxFit.cover,
                                  //       height: 20,
                                  //     )),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.only(left: 20),
                                  margin: EdgeInsets.symmetric(vertical: 18.0),
                                  height: 250.0,
                                  child: (places.length > 0)
                                      ? ListView.builder(
                                          //ตั้งให้แสดงขึ้นมา 5 ที่โดยไม่ได้กำหนดระยะทาง
                                          itemCount: 5,
                                          // itemCount: places.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            final photoReference = places[index]
                                                    .photos
                                                    .isEmpty
                                                ? ''
                                                : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${places[index].photos[0].photoReference}&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno";

                                            return FutureProvider(
                                              create: (context) =>
                                                  geoService.getDistance(
                                                      currentPosition.latitude,
                                                      currentPosition.longitude,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: GestureDetector(
                                                  child: boxes(
                                                      //ระเบิด !!!! .photos[0] ถ้าไม่มีรูปอยู่ใน list เรียกรูปออกมาไม่ได้ = ERROR !!!!!
                                                      //"https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${places[index].photos[0].photoReference}&key=AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno",
                                                      photoReference,
                                                      // '',
                                                      currentPosition.latitude,
                                                      currentPosition.longitude,
                                                      "${places[index].name}",
                                                      // "${places[index].name}",
                                                      /*score*/ places[index]
                                                          .userRatingsTotal,
                                                      /*rating*/ places[index],
                                                      /*address*/ places[index]
                                                          .vicinity,
                                                      /**openClose */
                                                      //'',

                                                      '${places[index].openingHours == null || places[index].openingHours.open_now.toString() == 'true' ? "เปิดทำการ" : "ปิดทำการ"}',
                                                      context),
                                                  onTap: () async {
                                                    final placeDetail =
                                                        await placesService
                                                            .getPlaceDetail(
                                                                places[index]
                                                                    .placeId);

                                                    Navigator.pushNamed(
                                                      context,
                                                      '/third',
                                                      arguments: {
                                                        'places': places[index],
                                                        'places_detail':
                                                            placeDetail,
                                                        


                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text('No, Found Nearby'),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 55,
                                left: 20,
                                right: 20,
                                child: Search(),
                              ),

                              // Align(
                              //   alignment: Alignment.bottomRight,
                              //   child: Padding(
                              //     padding: EdgeInsets.all(10),
                              //     child: FloatingActionButton.extended(
                              //       onPressed: () {
                              //         searchNearby(lat, lng);
                              //       },
                              //       label: Text('Places Nearby'),
                              //       icon: Icon(Icons.place),
                              //     ),
                              //   ),
                              // ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  // void searchNearby(double lat, double lng) async {
  //   final applicationBloc = Provider.of<ApplicationBloc>(context);
  //   double lat = applicationBloc.currentLocation.longitude;
  //   double lng = applicationBloc.currentLocation.latitude;
  //   // static double latitude = applicationBloc.currentLocation.longitude;
  //   // static double longitude = applicationBloc.currentLocation.latitude;
  //   setState(() {
  //     markers.clear();
  //   });
  //   dynamic /*String */ url =
  //       '$baseUrl?key=$_API_KEY&location=$lat,$lng&radius=1500&keyword=toilets';
  //   print(url);
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     _handleResponse(data);
  //   } else {
  //     throw Exception('An error occurred getting places nearby');
  //   }

  //   // make sure to hide searching
  //   setState(() {
  //     searching = false;
  //   });
  // }

  // void _handleResponse(data) {
  //   // bad api key or otherwise
  //   if (data['status'] == "REQUEST_DENIED") {
  //     setState(() {
  //       error = Error.fromJson(data);
  //     });
  //     // success
  //   } else if (data['status'] == "OK") {
  //     setState(() {
  //       places = PlaceResponse.parseResults(data['results']);
  //       for (int i = 0; i < places.length; i++) {
  //         markers.add(
  //           Marker(
  //             markerId: MarkerId(places[i].placeId),
  //             // icon: BitmapDescriptor.defaultMarkerWithHue(198.0),
  //             icon: pinLocationIcon,
  //             position: LatLng(places[i].geometry.location.lat,
  //                 places[i].geometry.location.lng),
  //             infoWindow: InfoWindow(
  //                 title: places[i].name, snippet: places[i].vicinity),
  //             onTap: () {},
  //           ),
  //         );
  //       }
  //     });
  //   } else {
  //     print(data);
  //   }
  // }
}
