import 'dart:async';

import 'package:ToiletPocket/blocs/application_bloc2.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class Homeonescreen extends StatefulWidget {
  Homeonescreen({Key key}) : super(key: key);

  @override
  _HomeonescreenState createState() => _HomeonescreenState();
}

class _HomeonescreenState extends State<Homeonescreen> {
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

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                maps(),
                _buildContainer(),
                Positioned(top: 50, left: 20, right: 20, child: search()),
              ],
            ),
    );
  }

  Widget search() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Column(
      children: [
        Padding(
          //old
          padding: const EdgeInsets.only(top: 8.0),
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
                suffixIcon: IconButton(
                  // onPressed: () => ,
                  onPressed: () {
                    Navigator.pushNamed(context, '/four');
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.black54,
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

  Widget load() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final icons = [Icons.place];

    return Stack(
      children: [
        if (applicationBloc.searchResults != null &&
            applicationBloc.searchResults.length != 0)
          Container(
              height: 300.0,
              width: double.infinity,
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
                  ])),
        if (applicationBloc.searchResults != null)
          Container(
            height: 300.0,
            child: ListView.separated(
              itemCount: applicationBloc.searchResults.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: Icon(Icons.location_city,color: Colors.black,),
                  leading: Icon(icons[index]),
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

  Widget maps() {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Stack(children: [
      Container(
        // height: 600.0,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          padding: EdgeInsets.only(top: 100),
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            zoom: 16,
            tilt: 50,
            // bearing: 30,
            target: LatLng(applicationBloc.currentLocation.latitude,
                applicationBloc.currentLocation.longitude),
          ),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          markers: Set<Marker>.of(applicationBloc.markers),
        ),
      ),
    ]);
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

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 18.0),
        height: 250.0,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipORp6yyQOYLlycgjzYCXOgNjykKvfFlPrkTHPxo=w408-h272-k-no",
                  13.65004,
                  100.49449,
                  "มหาวิทยาลัยเทคโนโลยีพระจอมเกล้าธนบุรี"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipPBP8muRmeYLaGWKkKFmXaSHHs2WH55Ah4AKYeh=w408-h271-k-no",
                  13.66,
                  100.49449,
                  "KMUTT Library"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipP-W915Ac24QVcnF3WKnDx6KxyPoM6HL74zWfPZ=w408-h306-k-no",
                  13.65004,
                  100.49449,
                  "โรงอาหาร มจธ."),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no",
                  40.761421,
                  -73.981667,
                  "Le Bernardin"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://images.unsplash.com/photo-1504940892017-d23b9053d5d4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                  40.732128,
                  -73.999619,
                  "Blue Hill"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        // _gotoLocation(lat, long);
        // Navigator.pushNamed(context, '/third');
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
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    width: 800,
                    height: 450,
                    // height: MediaQuery.of(context).size.width + 5,
                    padding: const EdgeInsets.only(
                        bottom: 40, top: 30, left: 20, right: 20),
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: myDetailsContainer1(restaurantName),
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
                                    _gotoLocation(lat, long);
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

  Widget myDetailsContainer1(String restaurantName) {
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
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Text(
                "4.1",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 40.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                ),
              )),
              // SizedBox(width: 10.0),
              Container(
                child: Icon(
                  OMIcons.star,
                  color: Colors.amber,
                  size: 35.0,
                ),
              ),
              // SizedBox(width: 8.0),
              Container(
                child: Icon(
                  OMIcons.star,
                  color: Colors.amber,
                  size: 35.0,
                ),
              ),
              // SizedBox(width: 8.0),
              Container(
                child: Icon(
                  OMIcons.star,
                  color: Colors.amber,
                  size: 35.0,
                ),
              ),
              // SizedBox(width: 8.0),
              Container(
                child: Icon(
                  OMIcons.star,
                  color: Colors.amber,
                  size: 35.0,
                ),
              ),
              // SizedBox(width: 8.0),
              Container(
                child: Icon(
                  OMIcons.starHalf,
                  color: Colors.amber,
                  size: 35.0,
                ),
              ),
              // SizedBox(width: 8.0),
              Container(
                  child: Text(
                "(946)",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                ),
              )),
            ],
          ),
          // SizedBox(height: 5.0),
          Row(
            children: [
              Container(
                  child: Text(
                "Kmutt \u00B7 ",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 35.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                ),
              )),
              Container(child: Icon(OMIcons.directionsCar)),
              Container(
                  child: Text(
                "\u00B7 1.6 mi",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 30.0,
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                ),
              )),
            ],
          ),
          // SizedBox(height: 5.0),
          Container(
            child: new Row(
              children: <Widget>[
                Text(
                  "Closed \u00B7 Opens 17:00 Thu",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 35.0,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(width: 50.0),
                Text(
                  "500 เมตร",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35.0,
                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          // SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _mapController.future;
    //old -------------------------------------------------------------
    // final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker kmuttMarker = Marker(
  markerId: MarkerId('Kumtt'),
  position: LatLng(13.65004, 100.49449),
  infoWindow: InfoWindow(title: 'มหาวิทยาลัยเทคโนโลยี\nพระจอมเกล้าธนบุรี'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(40.761421, -73.981667),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(40.732128, -73.999619),
  infoWindow: InfoWindow(title: 'Blue Hill'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

//New York Marker

Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(40.729640, -73.983510),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(40.719109, -74.000183),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
