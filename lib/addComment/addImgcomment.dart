import 'dart:io';

import 'package:ToiletPocket/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Addimgcomment extends StatefulWidget {
  Addimgcomment({Key key}) : super(key: key);
  @override
  _AddimgcommentState createState() => _AddimgcommentState();
}

class _AddimgcommentState extends State<Addimgcomment> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(top: 5, left: 0),
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          padding: const EdgeInsets.only(left: 3),
          alignment: Alignment.topLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: AssetThumb(
              asset: asset,
              width: 200,
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
        maxImages: 4,
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

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        Column(
          children: <Widget>[
            //  Expanded(
            //   child: buildGridView(),
            // ),
            Row(
              children: [
                Container(
                  // padding: EdgeInsets.only(top: 36),
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 83,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ToiletColors.colorButton,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      highlightColor: Colors.white,
                      onPressed: () {
                        loadAssets();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "แย่",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.5,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "ควรปรับปรุง",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.5,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "พอใช้",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.5,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "ดี",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.5,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "ดีเยี่ยม",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 7.5,
                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star,
                                color: Colors.amber[100], size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                            Icon(Icons.star, color: Colors.amber, size: 12),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
