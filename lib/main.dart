import 'package:ToiletPocket/Show_toiletDetail_review/toiletdetail.dart';
import 'package:ToiletPocket/addToilet_InMap/addToilet.dart';
import 'package:ToiletPocket/addToilet_InMap/addToiletDetail.dart';
import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/screen/firstScreen.dart';
import 'package:ToiletPocket/screen/homepage.dart';
import 'package:ToiletPocket/screen/profile.dart';
import 'package:ToiletPocket/services/geolocator_service.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoLocatorService = GeoLocatorService();
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    // final applicationBloc = Provider.of<ApplicationBloc>(context);

    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => geoLocatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration =
              createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(
              configuration, 'images/flush.png');
        }),
        ProxyProvider2<Position, BitmapDescriptor, Future<List<Places>>>(
          update: (context, position, icon, places) {
            return (position != null)
                ? placesService.getPlaces(
                    position.latitude, position.longitude, icon)
                : null;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ApplicationBloc(),
        ), //new
      ],
      child: MaterialApp(
        title: 'Toilet App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/two',
        routes: <String, WidgetBuilder>{
          '/one': (context) => FirstScreen(),
          '/two': (context) => HomePage(),
          '/third': (context) => ToiletDetail(),
          '/four': (context) => profile(context),
          '/five': (context) => addToilet(),
          '/six': (context) => AddToiletDetail(),
        },
      ),
    );
  }
}
