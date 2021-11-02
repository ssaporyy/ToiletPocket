import 'package:ToiletPocket/addComment/addImgcomment.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AddComment extends StatefulWidget {
  const AddComment({Key key}) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class Comment {
  String review;
}

class _AddCommentState extends State<AddComment> {
  final user = FirebaseAuth.instance.currentUser;

  final fromKey = GlobalKey<FormState>();
  Comment userComment = Comment();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference addComment =
      FirebaseFirestore.instance.collection('comment');
  double rating = 3.0;
  @override
  Widget build(BuildContext context) {
    String timestamp;

    DateTime now = DateTime.now();
    String formatDate = DateFormat('d MMM, hh:mm a').format(now);
    timestamp = formatDate;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Container(
                child: Stack(
                  children: <Widget>[
                    Scaffold(
                      body: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                image: DecorationImage(
                                    alignment: Alignment.topCenter,
                                    image: AssetImage("images/banner.png"),
                                    fit: BoxFit.scaleDown)),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 43.0, left: 30.0, right: 0.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/two');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 18,
                                    color: Colors.black87,
                                  ),
                                  Text(
                                    'กลับ',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15.0,
                                      fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20, top: 90),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: ToiletColors.colorBackground
                                        .withOpacity(0.9), //color of shadow
                                    spreadRadius: 5, //spread radius
                                    blurRadius: 7, // blur radius
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.topCenter,
                                // child: addDetail(context)
                                child: Container(
                                  padding: EdgeInsets.only(left: 0, top: 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "รีวิวและประเมินห้องน้ำ",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 11,
                                                          color: Colors.white,
                                                          spreadRadius: 6)
                                                    ],
                                                  ),
                                                  child: CircleAvatar(
                                                    radius: 45.0,
                                                    backgroundImage:
                                                        NetworkImage(user ==
                                                                    null ||
                                                                user.isAnonymous
                                                            ? 'https://api-private.atlassian.com/users/59e6130472109b7dbf87e89b024ef0b0/avatar'
                                                            : (user.photoURL)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  // 'Haruto',
                                                  (user == null ||
                                                          user.isAnonymous
                                                      ? 'My Name'
                                                      : '${user.displayName} '),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontFamily:
                                                        'Sukhumvit' ?? 'SF-Pro',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        //star ดาว
                                        Container(
                                            height: 70,
                                            //ส่วนนี้เป็นดาวที่ให้เรทติ้งที่อยู่ หน้า star.dart
                                            child:
                                                // Star()
                                                Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SmoothStarRating(
                                                    rating: rating,
                                                    borderColor: Colors.amber,
                                                    color: Colors.amber,
                                                    size: 35,
                                                    filledIconData: Icons.star,
                                                    halfFilledIconData:
                                                        Icons.star_half,
                                                    defaultIconData:
                                                        Icons.star_border,
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
                                                        : ((rating < 5.0) &
                                                                (rating > 3.0))
                                                            ? 'ดี'
                                                            : ((rating < 4.0) &
                                                                    (rating >
                                                                        2.0))
                                                                ? 'พอใช้'
                                                                : ((rating <
                                                                            3.0) &
                                                                        (rating >
                                                                            1.0))
                                                                    ? 'ควรปรับปรุง'
                                                                    : ((rating <
                                                                                2.0) &
                                                                            (rating >
                                                                                0.0))
                                                                        ? 'แย่'
                                                                        : 'คะแนนความพึงพอใจ',
                                                    style: TextStyle(
                                                      fontFamily: 'Sukhumvit' ??
                                                          'SF-Pro',
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 15,
                                                top: 10),
                                            padding:
                                                EdgeInsets.only(bottom: 0.0),
                                            child: Flexible(
                                              child: Form(
                                                key: fromKey,
                                                child: TextFormField(
                                                  autofocus: true,
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily:
                                                        'Sukhumvit' ?? 'SF-Pro',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 4,
                                                  decoration: InputDecoration(
                                                    hintText: "แสดงความคิดเห็น",
                                                    hintStyle: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'Sukhumvit' ??
                                                                'SF-Pro',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black45),
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  onSaved: (String review) {
                                                    userComment.review = review;
                                                  },
                                                  validator: RequiredValidator(
                                                      errorText:
                                                          "Please comment"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 0),
                                          child: addPhotocomment(context),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 20),
                                          child:
                                              // confirm(context),
                                              Container(
                                            margin: EdgeInsets.only(top: 0),
                                            width: 120,
                                            child: MaterialButton(
                                              // RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13.0),
                                                  side: BorderSide(
                                                      color: ToiletColors
                                                          .colorButton2)),
                                              onPressed: () async {
                                                //ยืนยัน
                                                if (fromKey.currentState
                                                    .validate()) {
                                                  fromKey.currentState.save();
                                                  await addComment.add({
                                                    'usercomment':
                                                        userComment.review,
                                                    'uid': user.uid,
                                                    'imgURL': user.photoURL,
                                                    'userName':
                                                        user.displayName,
                                                    'time': timestamp,
                                                    'rating': rating,
                                                  });
                                                  fromKey.currentState.reset();
                                                }
                                                Navigator.pushNamed(
                                                    context, '/o');
                                              },

                                              padding: EdgeInsets.all(10.0),
                                              color: ToiletColors.colorButton2,
                                              textColor: Colors.white,
                                              child: Text(
                                                "ยืนยัน",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily:
                                                      'Sukhumvit' ?? 'SF-Pro',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(height: 50,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

Widget addPhotocomment(BuildContext context) {
  return Container(
    color: Colors.white,
    alignment: Alignment.topLeft,
    child: Container(
      height: 165,
      width: 280,
      child: Addimgcomment(),
      alignment: Alignment.topLeft,
    ),
  );
}
