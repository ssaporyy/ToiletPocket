import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
          // toiletName,
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
                  // '($score)',
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
                              // '$address',
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
                    color: openClose == 'ปิดทำการ' ? Colors.red : Colors.green,
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
