// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class addImage extends StatefulWidget {
//   addImage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _addImageState createState() => _addImageState();
// }

// class _addImageState extends State<addImage> {
//   File _image;
//   _imgFromCamera() async {
//     File image = await ImagePicker.pickImage(
//         source: ImageSource.camera, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   _imgFromGallery() async {
//     File image = await ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(padding: EdgeInsets.only(top: 10,left: 10,bottom: 10),
//         child: InkWell(
//           onTap: () {
//           }, // Handle your callback
//           child: Ink(
//             child: IconButton(onPressed: (){_showPicker(context);}, icon: Icon(Icons.add,color: Colors.grey,size: 30,)),
//             height: 150,
//             width: 200,
//             decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(10.0),bottom: Radius.circular(10.0)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey[200],
//                     //color of shadow
//                     spreadRadius: 3, //spread radius
//                     blurRadius: 9, // blur radius
//                     offset: Offset(0, 2), // changes position of shadow

//                   ),
//                 ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class addImage extends StatefulWidget {
  addImage({Key key}) : super(key: key);
  @override
  _addImageState createState() => _addImageState();
}

class _addImageState extends State<addImage> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      padding: EdgeInsets.only(top: 0, left: 4),
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          padding: const EdgeInsets.all(3),
          alignment: Alignment.topLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AssetThumb(
              asset: asset,
              width: 150,
              height: 150,
            ),
          ),
        );
        // AssetThumb(
        //   asset: asset,
        //   width: 300,
        //   height: 300,
        // );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#9690ff",
          actionBarTitle: "Toilet Pocket",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        Row(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(top: 36),
              alignment: Alignment.topLeft,
              child: Container(
                height: 83,
                width: 83,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ToiletColors.colorButton,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  highlightColor: Colors.white,
                  onPressed: loadAssets,
                ),
              ),
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}
