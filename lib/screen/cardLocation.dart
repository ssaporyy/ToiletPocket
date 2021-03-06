import 'package:ToiletPocket/directionModel/direction.dart';
import 'package:ToiletPocket/models/places.dart';
import 'package:ToiletPocket/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

Widget myDetailsContainer1(String toiletName, score, rating, address, openClose,
    BuildContext context) {
  return Container(
    alignment: Alignment.topLeft,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          toiletName,
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
                              maxLines: 1,
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
          ],
        ),
        SizedBox(height: 15.0),
        Container(
          child: new Row(
            children: <Widget>[
              Text(
                openClose,
                style: TextStyle(
                    color: openClose == '????????????????????????' ? Colors.red : Colors.green,
                    fontSize: 30.0,
                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(width: 50.0),
              
            ],
          ),
        ),
      ],
    ),
  );
}
