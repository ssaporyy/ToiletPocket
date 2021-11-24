// import 'dart:html';

// import 'package:ToiletPocket/addComment/addReviewComment.dart';
// import 'package:ToiletPocket/colors.dart';
// import 'package:ToiletPocket/models/places.dart';
// import 'package:ToiletPocket/show_toiletDetail_review/comment.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ToiletPocket/models/reviews.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';


Widget user() {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: CircleAvatar(
      backgroundImage: NetworkImage(
          'https://cdn.readawrite.com/articles/1821/1820201/thumbnail/large.gif?3'),
      radius: 30,
    ),
  );
}

Widget star() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.amber),
      Icon(Icons.star, color: Colors.black87),
      Icon(Icons.star, color: Colors.black87),
    ],
  );
}

Widget nameAndreview() {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          // verticalDirection: VerticalDirection.down,
          children: [
        Text(
          "Watanabe Haruto",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "ห้องน้ำสะอาด มีเจลล้างมือ ประตูไม่มีการชำรุด",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            fontWeight: FontWeight.w500,
          ),
        )
      ]));
}

Widget picture() {
  return Row(
    children: [
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            "https://shrm-res.cloudinary.com/image/upload/c_crop,h_1574,w_2800,x_0,y_0/w_auto:100,w_1200,q_35,f_auto/v1/Risk%20Management/iStock-182768607_zzxdq5.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 10),
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://whyy.org/wp-content/uploads/2020/04/bigstock-Toilet-Shot-In-Detail-In-A-Whi-236077285.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(width: 10),
      Container(
        // width: double.infinity,
        // height: double.infinity,
        width: 60,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://media4.s-nbcnews.com/i/newscms/2020_26/1583450/public-restroom-corona-kb-main-200623_9519eb6bd31f5da24860f90cb8fc60af.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}
