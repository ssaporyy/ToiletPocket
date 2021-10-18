import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Star extends StatefulWidget {
  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  double rating = 3.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   "Library :  '$result' ",
          //   style: TextStyle(fontSize: 20),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          SmoothStarRating(
            rating: rating,
            borderColor: Colors.amber,
            color: Colors.amber,
            size: 35,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: false,
            spacing: 2.0,
            onRated: (value) {
              setState(() {
                rating = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            // "คุณให้คะแนน $rating คะแนน",
            rating == 5.0
                ? 'ดีเยี่ยม'
                : ((rating < 5.0) & (rating > 3.0))
                    ? 'ดี'
                    : ((rating < 4.0) & (rating > 2.0))
                        ? 'พอใช้'
                        : ((rating < 3.0) & (rating > 1.0))
                            ? 'ควรปรับปรุง'
                            : ((rating < 2.0) & (rating > 0.0))
                                ? 'แย่'
                                : 'คะแนนความพึงพอใจ',
            style: TextStyle(
              fontFamily: 'Sukhumvit',
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ));
  }
}
