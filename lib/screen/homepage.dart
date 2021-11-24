import 'dart:async';

import 'package:ToiletPocket/blocs/application_bloc.dart';
// import 'package:ToiletPocket/models/open.dart';
// import 'package:ToiletPocket/models/place_response.dart';
import 'package:ToiletPocket/models/places.dart';
// import 'package:ToiletPocket/models/result.dart';
import 'package:ToiletPocket/screen/cardLocation.dart';
import 'package:ToiletPocket/screen/search.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:ToiletPocket/services/marker_service.dart';

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
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

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

  // Future<void> _gotoMarker(double lat, double long) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(lat, long),
  //     zoom: 16,
  //     tilt: 50.0,
  //     // bearing: 45.0,
  //   )));
  // }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Places>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //new
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    List<Marker> _marker = <Marker>[];

    return FutureProvider(
      create: (context) => placesProvider,
      child: Container(
        child: Scaffold(
          body: (currentPosition != null)
              ? Consumer<List<Places>>(
                  builder: (_, places, __) {
                    var markers = (places != null)
                        ? markerService.getMarkers(places)
                        : _marker;

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

                                  onCameraMove: (position) {
                                    print(position.target);
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
                                      onPressed: () async {
                                        // Navigate to the second screen using a named route.

                                        Navigator.pushNamed(
                                          context,
                                          '/five',
                                          arguments: {
                                            'currentlocation':
                                                applicationBloc.currentLocation,
                                          },
                                        );
                                      },
                                    ),
                                  ),
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
                                            // print(
                                            //   'lat:-----------------------------------------------------------------${applicationBloc.selectedLocationStatic.geometry.location.lat}',
                                            // );
                                            // print(
                                            //   'lng:-----------------------------------------------------------------${applicationBloc.selectedLocationStatic.geometry.location.lng}',
                                            // );
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
                                                    .lng,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: GestureDetector(
                                                  child: boxes(
                                                      photoReference,
                                                      // '',

                                                      // 13.1667,100.9333,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lat,
                                                      places[index]
                                                          .geometry
                                                          .location
                                                          .lng,
                                                      // currentPosition.latitude,
                                                      // currentPosition.longitude,
                                                      "${places[index].name}",
                                                      // "${places[index].name}",
                                                      /*score*/ places[index]
                                                          .userRatingsTotal,
                                                      /*rating*/ places[index],
                                                      /*address*/ places[index]
                                                          .vicinity,
                                                      places[index],
                                                      // places[index],
                                                      currentPosition,
                                                      
                                                        currentPosition
                                                            .latitude,
                                                        currentPosition
                                                            .longitude,
                                                        places[index]
                                                            .geometry
                                                            .location
                                                            .lat,
                                                        places[index]
                                                            .geometry
                                                            .location
                                                            .lng,
                                                      
                                                      /**openClose */
                                                      //'',
                                                      '${places[index].openingHours == null || places[index].openingHours.openNow.toString() == 'true' ? "เปิดทำการ" : "ปิดทำการ"}',
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

  Widget boxes(
    String _image,
    double lat,
    double long,
    String toiletName,
    score,
    rating,
    address,
    push,
    navigate,
    lat1,
    lng1,
    lat2,
    lng2,
    openClose,
    BuildContext context,
  ) {
    final placesService = PlacesService();
    return Container(
      child: new FittedBox(
        fit: BoxFit.cover,
        child: Material(
            color: Colors.white,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 850,
                  height: 400,
                  // height: MediaQuery.of(context).size.width + 5,
                  // width: MediaQuery.of(context).size.width / 3,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(0.0),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        _image.isEmpty
                            ? 'https://www.sarras-shop.com/out/pictures/master/product/1/no-image-available-icon.jpg'
                            : _image,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 800,
                  height: 450,
                  // height: MediaQuery.of(context).size.width + 5,
                  padding: const EdgeInsets.only(
                      bottom: 40, top: 15, left: 20, right: 20),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: myDetailsContainer1(toiletName, score, rating,
                            address, openClose, context),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 90,
                              width: 240,
                              child: RaisedButton(
                                color: ToiletColors.colorButton,

                                onPressed: () async {
                                  //กดไปหน้า นำทาง
                                  //set direction
                                  final direction = await placesService.getDirection(lat1, lng1, lat2, lng2);

                                  Navigator.pushNamed(
                                    context,
                                    '/eight',
                                    arguments: {
                                      'places': push,
                                      'current': navigate,
                                      'direction': direction,
                                    },
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15),
                                    bottom: Radius.circular(15),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Icon(
                                      Icons.directions,
                                      color: ToiletColors.colorText,
                                      size: 35,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      'เส้นทาง',
                                      style: TextStyle(
                                        color: ToiletColors.colorText,
                                        fontSize: 30.0,
                                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                        // fontWeight: FontWeight.normal
                                      ),
                                    ),
                                  ],
                                ),
                                elevation: 1,
                                padding: new EdgeInsets.fromLTRB(28, 7, 28, 7),
                              ),
                            ),
                            // SizedBox(width: 50.0),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    width: 85.0,
                                    height: 80.0,
                                    child: RaisedButton(
                                      color: ToiletColors.colorButton,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                          bottom: Radius.circular(30),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.smoking_rooms_rounded,
                                        color: ToiletColors.colorText,
                                        size: 35,
                                      ),
                                      elevation: 1,
                                      padding:
                                          new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Container(
                                    width: 85.0,
                                    height: 80.0,
                                    child: RaisedButton(
                                      color: ToiletColors.colorButton,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                          bottom: Radius.circular(30),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.accessible,
                                        color: ToiletColors.colorText,
                                        size: 35,
                                      ),
                                      elevation: 1,
                                      padding:
                                          new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Container(
                                    width: 85.0,
                                    height: 80.0,
                                    child: RaisedButton(
                                      color: ToiletColors.colorButton,
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                          bottom: Radius.circular(30),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.wc,
                                        color: ToiletColors.colorText,
                                        size: 35,
                                      ),
                                      elevation: 1,
                                      padding:
                                          new EdgeInsets.fromLTRB(3, 7, 3, 7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
