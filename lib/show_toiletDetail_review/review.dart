// import 'package:ToiletPocket/directionModel/DistanceMatrix.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   runApp(new Test(
//     distanceMatrix: await DistanceMatrix.loadData(),
//   ));
// }

// class Test extends StatefulWidget {
//   final DistanceMatrix distanceMatrix;

//   @override
//   _TestState createState() => new _TestState();

//   Test({this.distanceMatrix});
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text("Home"),
//             ),
//             body: Material(
//                 child: ListView.builder(
//                 itemCount: widget.distanceMatrix.elements.length,
//                 itemBuilder: (context, index){
//                   return ListTile(
//                     title: Text(widget.distanceMatrix.elements[index].distance.text),
//                     subtitle: Text(widget.distanceMatrix.elements[index].distance.value.toString()),
//                   );
//                 },
//               )
//             )));
//   }
// }

