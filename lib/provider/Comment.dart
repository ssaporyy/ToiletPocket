// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class CommentPost {
//   CollectionReference addcomment =
//       FirebaseFirestore.instance.collection('Comment');

//   Future newComment(double rating, String text, String uid) async {
//     return await addcomment.doc(uid).set({
//       'comment': text,
//       'rate': rating,
//       // 'datetime': DateTime.now(),
//     });
//   }
// }
