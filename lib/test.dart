import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double rating = 3.0;
  // String result = 'Good';
  // String result2 = 'Bad';

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
                    print(rating);

                    // if (value == 1.0) {
                    //   print('result1');
                    // }
                    // if (value == 2.0) {
                    //   print('result2');
                    // }
                    // if (value == 3.0) {
                    //   print('result3');
                    // }
                    // if (value == 4.0) {
                    //   print('result4');
                    // }
                    // if (value == 5.0) {
                    //   print('result5');
                    // }
                  });
                },
              ),
              SizedBox(height: 5,),
              Text(
                "คุณให้คะแนน $rating คะแนน",
                style: TextStyle(
                  fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ));
  }
}
