import 'dart:async';


import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/models/place_response.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/models/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    //new
    setCustomMapPin();
  }

  //new
  BitmapDescriptor pinLocationIcon;
  Error error;
  List<Result> places;
  bool searching = true;
  String keyword;
  List<Marker> markers = <Marker>[];
  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const String _API_KEY = 'AIzaSyBcpcEqe0gn9DwPRPzRvrqSvDtLZpvTtno';
  double lat;
  double lng;
  // static double latitude = 13.736717;
  // static double longitude = 100.523186;
//new
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), 'assets/Icon-flush.png');
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
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Places>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    //new
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        body: (applicationBloc.currentLocation != null)
            // ? Consumer<List<Result>>(
            ? Consumer<List<Places>>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? applicationBloc.markerService.getMarkers(places)
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
                                    target: LatLng(
                                        applicationBloc
                                            .currentLocation.latitude,
                                        applicationBloc
                                            .currentLocation.longitude),
                                    zoom: 13.0),
                                zoomGesturesEnabled: true,
                                onMapCreated: (GoogleMapController controller) {
                                  _mapController.complete(controller);
                                },
                                markers: Set<Marker>.of(markers),
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
                                        itemCount: places.length = 5,
                                        // itemCount: places.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return FutureProvider(
                                            create: (context) =>
                                                geoService.getDistance(
                                                    applicationBloc
                                                        .currentLocation
                                                        .latitude,
                                                    applicationBloc
                                                        .currentLocation
                                                        .longitude,
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
                                              child: _boxes(
                                                // "${places[index].photos}",
                                                "",
                                                // "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                                                applicationBloc
                                                    .currentLocation.latitude,
                                                applicationBloc
                                                    .currentLocation.longitude,
                                                "${places[index].name}",
                                                // "${places[index].name}",
                                                /*score*/ places[index]
                                                    .userRatingsTotal,
                                                /*rating*/ places[index],
                                                /*address*/ places[index]
                                                    .vicinity,
                                                /**test */ '',
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text('No Parking Found Nearby'),
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: 20,
                              right: 20,
                              child: search(),
                            ),

                            // Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: Padding(
                            //     padding: EdgeInsets.all(10),
                            //     child: FloatingActionButton.extended(
                            //       onPressed: () {
                            //         searchNearby(applicationBloc.selectedLocationStatic.geometry.location.lat, applicationBloc.selectedLocationStatic.geometry.location.lng);
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
    );
  }

//เครื่องหมายนำทางเด้งไปแอพ maps
  // void _launchMapsUrl(double lat, double lng) async {
  //   final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void searchNearby(double lat, double lng) async {
    setState(() {
      markers.clear();
    });
    String url =
        '$baseUrl?key=$_API_KEY&location=$lat,$lng&radius=1500&keyword=toilets';
    print(url);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }

    // make sure to hide searching
    setState(() {
      searching = false;
    });
  }

  void _handleResponse(data) {
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              // icon: BitmapDescriptor.defaultMarkerWithHue(198.0),
              icon: pinLocationIcon,
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.lng),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }

  Widget search() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    // var txt = TextEditingController();

    return Column(
      children: [
        Padding(
          //old
          padding: const EdgeInsets.only(top: 0.0),
          // padding: const EdgeInsets.all(8.0),
          //new
          child: Container(
            // width: MediaQuery.of(context).size.width +50,
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // margin: EdgeInsets.only(top: 80.0, left: 40.0, right: 40.0),
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
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundImage:
                              // NetworkImage(_googleSignIn.currentUser.photoUrl),
                              NetworkImage(
                                  'https://pbs.twimg.com/media/E1zDPp6VIAIna9y?format=jpg&name=large'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onChanged: (value) => applicationBloc.searchPlaces(value),
              // onTap: () => applicationBloc.clearSelectedLocation(),
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
                    // applicationBloc.setSelectedLocation(
                    //     applicationBloc.searchResults[index].placeId);
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

  /////////////////////////////////////////// new
  // Future<void> _goToPlace(Place place) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(
  //               place.geometry.location.lat, place.geometry.location.lng),
  //           zoom: 14.0),
  //     ),
  //   );
  // }

  // Future<void> _gotoLocation(double lat, double long,context) async {
  //   // final GoogleMapController controller = await _mapController.future;
  //   //old -------------------------------------------------------------
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //   // controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(place.geometry.location.lat, place.geometry.location.lng),
  //     // target: LatLng(lat, long),
  //     zoom: 15,
  //     tilt: 50.0,
  //     bearing: 45.0,
  //   )));
  // }

  Widget _boxes(String _image, double lat, double long, String restaurantName,
      score, rating, address, testt) {
    return GestureDetector(
      onTap: () {
        // _gotoLocation(lat, long);
        Navigator.pushNamed(context, '/third');
      },
      child: Container(
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
                          _image,
                        ),
                        errorBuilder: (context, exception, stackTrack) =>
                            Container(
                          color: ToiletColors.colorButton,
                          child: Icon(
                            Icons.collections,
                            size: 100,
                            color: ToiletColors.colorPurple,
                          ),
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
                          child: myDetailsContainer1(
                              restaurantName, score, rating, address, testt),
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
                                  onPressed: () {
                                    //กดไปหน้า นำทาง
                                    // _gotoLocation(lat, long);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15),
                                      bottom: Radius.circular(15),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  padding:
                                      new EdgeInsets.fromLTRB(28, 7, 28, 7),
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
      ),
    );
  }

  // Widget myDetailsContainer1(String restaurantName, context, index) {
  Widget myDetailsContainer1(
      String restaurantName, score, rating, address, testt) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            restaurantName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color(0xff6200ee),
                fontSize: 40.0,
                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  RatingBarIndicator(
                    rating: rating.rating,
                    itemBuilder: (context, index) =>
                        Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 40.0,
                    direction: Axis.horizontal,
                  ),
                  Text(
                    '($score)',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 35.0,
                        fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<double>(
                      builder: (context, meters, wiget) {
                        return (meters != null)
                            ? Text(
                                '$address',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 30.0,
                                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                    fontWeight: FontWeight.normal),
                              )
                            : Container();
                      },
                    ),
                  ],
                ),
              ),
              // Container(child: Icon(Icons.directions)),
              // Container(
              //     //mi
              //     child: Text(
              //   mi,
              //   style: TextStyle(
              //     color: Colors.black54,
              //     fontSize: 30.0,
              //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              //   ),
              // )),
            ],
          ),
          SizedBox(height: 15.0),
          Container(
            child: new Row(
              children: <Widget>[
                Text(
                  "Closed \u00B7 Opens 17:00 Thu",
                  // testt,

                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30.0,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 50.0),
                Consumer<double>(
                  builder: (context, meters, wiget) {
                    return (meters != null)
                        ? Text(
                            '\u00b7  ${(meters / 1609).round()} mi',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30.0,
                                fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                fontWeight: FontWeight.normal),
                          )
                        : Container();
                  },
                ),
                // Text(
                //   "500 เมตร",
                //   style: TextStyle(
                //       color: Colors.blue,
                //       fontSize: 35.0,
                //       fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                //       fontWeight: FontWeight.normal),
                // ),
              ],
            ),
          ),
          // SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
