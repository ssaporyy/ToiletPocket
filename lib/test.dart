import 'package:flutter/material.dart';

// class GetTextFieldValue extends StatefulWidget {
//   _TextFieldValueState createState() => _TextFieldValueState();
// }

// class _TextFieldValueState extends State<GetTextFieldValue> {
//   // final textFieldValueHolder = TextEditingController();

//   String result = '';

//   getTextInputData() {
//     setState(() {
//       result = 'good';
//     });
//   }
//   getTextInputData2() {
//     setState(() {
//       result = 'bad';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           RaisedButton(
//             onPressed: getTextInputData,
//             color: Color(0xffFF1744),
//             textColor: Colors.white,
//             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//             child: Text('Click Here'),
//           ),
//           RaisedButton(
//             onPressed: getTextInputData2,
//             color: Color(0xffFF1744),
//             textColor: Colors.white,
//             padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//             child: Text('Click Here'),
//           ),
//           Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text("$result", style: TextStyle(fontSize: 20)))
//         ],
//       ),
//     ));
//   }
// }

// class Test2 extends StatefulWidget {
//   @override
//   _TestState createState() => new _TestState();
// }

// class _TestState extends State<Test2> {
//   var _myColorOne = Colors.grey;
//   var _myColorTwo = Colors.grey;
//   var _myColorThree = Colors.grey;
//   var _myColorFour = Colors.grey;
//   var _myColorFive = Colors.grey;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("My Rating"),
//       ),
//       body: new Center(
//         child: new Container(
//           height: 10.0,
//           width: 500.0,
//           child: new Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               new IconButton(
//                 icon: new Icon(Icons.star),
//                 onPressed: () => setState(() {
//                   _myColorOne = Colors.orange;
//                   _myColorTwo = null;
//                   _myColorThree = null;
//                   _myColorFour = null;
//                   _myColorFive = null;
//                 }),
//                 color: _myColorOne,
//               ),
//               new IconButton(
//                 icon: new Icon(Icons.star),
//                 onPressed: () => setState(() {
//                   _myColorOne = Colors.orange;
//                   _myColorTwo = Colors.orange;
//                   _myColorThree = Colors.grey;
//                   _myColorFour = Colors.grey;
//                   _myColorFive = Colors.grey;
//                 }),
//                 color: _myColorTwo,
//               ),
//               new IconButton(
//                 icon: new Icon(Icons.star),
//                 onPressed: () => setState(() {
//                   _myColorOne = Colors.orange;
//                   _myColorTwo = Colors.orange;
//                   _myColorThree = Colors.orange;
//                   _myColorFour = Colors.grey;
//                   _myColorFive = Colors.grey;
//                 }),
//                 color: _myColorThree,
//               ),
//               new IconButton(
//                 icon: new Icon(Icons.star),
//                 onPressed: () => setState(() {
//                   _myColorOne = Colors.orange;
//                   _myColorTwo = Colors.orange;
//                   _myColorThree = Colors.orange;
//                   _myColorFour = Colors.orange;
//                   _myColorFive = Colors.grey;
//                 }),
//                 color: _myColorFour,
//               ),
//               new IconButton(
//                 icon: new Icon(Icons.star),
//                 onPressed: () => setState(() {
//                   _myColorOne = Colors.orange;
//                   _myColorTwo = Colors.orange;
//                   _myColorThree = Colors.orange;
//                   _myColorFour = Colors.orange;
//                   _myColorFive = Colors.orange;
//                 }),
//                 color: _myColorFive,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   double _ratingValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Kindacode.com'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(25),
//           child: Center(
//             child: Column(
//               children: [
//                 Text(
//                   'Rate our fictinal prodcut?',
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(height: 25),
//                 RatingBar(
//                     initialRating: 0,
//                     direction: Axis.horizontal,
//                     allowHalfRating: false,
//                     itemCount: 5,
//                     ratingWidget: RatingWidget(
//                         full: Icon(Icons.star, color: Colors.orange),
//                         half: Icon(
//                           Icons.star_half,
//                           color: Colors.orange,
//                         ),
//                         empty: Icon(
//                           Icons.star_outline,
//                           color: Colors.orange,
//                         )),
//                     onRatingUpdate: (value) {
//                       setState(() {
//                         _ratingValue = value;

//                         if (value != 1.0) {
//                           return 'Rate it!';
//                         } else {
//                           return 'bad';
//                         }
//                       });
//                     }),
//                 SizedBox(height: 25),
//                 Container(
//                   width: 200,
//                   height: 200,
//                   decoration:
//                       BoxDecoration(color: Colors.red, shape: BoxShape.circle),
//                   alignment: Alignment.center,
//                   child: Text(
//                     // _ratingValue != null ? _ratingValue.toString() : 'Rate it!',
//                     _ratingValue != null ? _ratingValue.toString() : 'Rate it!',

//                     style: TextStyle(color: Colors.white, fontSize: 30),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
