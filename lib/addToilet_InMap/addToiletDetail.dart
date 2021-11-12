import 'package:ToiletPocket/addToilet_InMap/addImage.dart';
import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:ToiletPocket/colors.dart';
import 'package:ToiletPocket/star2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class AddToiletDetail extends StatefulWidget {
  const AddToiletDetail({Key key}) : super(key: key);

  final String title = 'Wrap Widget & Chips';

  @override
  _AddToiletDetailState createState() => _AddToiletDetailState();
}

class Company {
  const Company(this.name);
  final String name;
}

class AddToilets {
  String placesname;
}

class _AddToiletDetailState extends State<AddToiletDetail> {
  final fromKey = GlobalKey<FormState>();
  CollectionReference addToilets =
      FirebaseFirestore.instance.collection('AddToilets');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  AddToilets userAddToilet = AddToilets();

  final user = FirebaseAuth.instance.currentUser;

  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  TimeOfDay _time2 = TimeOfDay(hour: 0, minute: 00);

  List<String> lst = ['ไม่เสียค่าใช้บริการ', 'เสียค่าใช้บริการ'];
  int selectedIndex = 0;

  List<IconData> iconList = [
    Icons.settings,
    Icons.bookmark,
    Icons.account_circle
  ];
  int secondaryIndex = 0;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        // print(_time);
        if (_time == newTime) {
          debugPrint('TimeOfOpen: $_time');
        }
      });
    }
  }

  void _selectTime2() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime != null) {
      setState(() {
        _time2 = newTime;
        // print(_time);
        if (_time2 == newTime) {
          debugPrint('TimeOfClosed: $_time2');
        }
      });
    }
  }

  List<Company> _companies;
  List<String> _filters;

  @override
  void initState() {
    _filters = <String>[];
    _companies = <Company>[
      //Men’s room
      const Company('ห้องน้ำชาย'),
      //Ladies’ room
      const Company('ห้องน้ำหญิง'),
      //disabled toilet
      const Company('ห้องน้ำสำหรับผู้พิการ'),
      //Smoking Area
      const Company('เขตสูบบุหรี่'),
    ];
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageAddToilet');
  }

  Iterable<Widget> get companyWidgets sync* {
    for (Company company in _companies) {
      yield Padding(
        padding: const EdgeInsets.only(left: 3),
        child: FilterChip(
          avatar: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('images/flush.png'),
            // Text(
            //   company.name[0].toUpperCase(),
            //   style: TextStyle(
            //     color: Colors.white,
            //     // fontWeight: FontWeight.w600,
            //     fontSize: 15,
            //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            //   ),
            // ),
          ),
          label: Text(
            company.name,
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.w600,
              fontSize: 10,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
            ),
          ),
          selected: _filters.contains(company.name),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _filters.add(company.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == company.name;
                });
              }
              print('Selected: ${_filters.join(', ')}');
            });
          },
        ),
      );
    }
  }

  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();

  chooseImage() async {
    WidgetsFlutterBinding.ensureInitialized();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    WidgetsFlutterBinding.ensureInitialized();

    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadInfo() async {
    // int i = 1;
    String timestamp;

    DateTime now = DateTime.now();
    String formatDate = DateFormat('d MMM, hh:mm a').format(now);
    timestamp = formatDate;

    List<String> imageUrlList = [];
    for (var img in _image) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img);
      final String downloadUrl = await ref.getDownloadURL();
      imageUrlList.add(downloadUrl);
    }
    imgRef.add({
      'url': imageUrlList,
      'time': timestamp,
    });
  }

  @override
  Widget build(BuildContext context) {
    double rating = 3.0;
    String timestamp;

    DateTime now = DateTime.now();
    String formatDate = DateFormat('d MMM, hh:mm a').format(now);
    timestamp = formatDate;

    final _args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _currentlocation = _args['currentlocation'] as Position;

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
                backgroundColor: ToiletColors.colorBackground,
                body: Container(
                    child: Stack(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 43.0, left: 20.0, right: 0.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, '/two');
                          Navigator.of(context).pop();
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: ToiletColors.colorBackground
                                .withOpacity(0.9), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(left: 0, top: 25),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "รายละเอียดห้องน้ำ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 80,
                                  //ยังไม่ได้แก้ ส่วนนี้เป็นดาวที่ให้เรทติ้งที่อยู่ หน้า star.dart
                                  child:
                                      // Star2()
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
                                              : ((rating < 5.0) &
                                                      (rating > 3.0))
                                                  ? 'ดี'
                                                  : ((rating < 4.0) &
                                                          (rating > 2.0))
                                                      ? 'พอใช้'
                                                      : ((rating < 3.0) &
                                                              (rating > 1.0))
                                                          ? 'ควรปรับปรุง'
                                                          : ((rating < 2.0) &
                                                                  (rating >
                                                                      0.0))
                                                              ? 'แย่'
                                                              : 'คะแนนความพึงพอใจ',
                                          style: TextStyle(
                                            fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 2),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: ListTile(
                                      leading: Icon(
                                        OMIcons.locationOn,
                                        color: ToiletColors.colorPurple,
                                        size: 36.0,
                                      ),
                                      title:
                                          // Text(
                                          //   // '126 ถ. ประชาอุทิศ แขวง บางมด เขตทุ่งครุ กรุงเทพมหานคร 10140',
                                          //   '',
                                          //   style: TextStyle(
                                          //     color: Colors.black,
                                          //     fontSize: 11.0,
                                          //     fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                          //     fontWeight: FontWeight.w500,
                                          //   ),
                                          // ),
                                          Flexible(
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
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              hintText: "ชื่อห้องน้ำ",
                                              hintStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'Sukhumvit' ?? 'SF-Pro',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black45),
                                              // border: OutlineInputBorder(),
                                            ),
                                            onSaved: (String placesname) {
                                              userAddToilet.placesname =
                                                  placesname;
                                            },
                                            validator: RequiredValidator(
                                                errorText:
                                                    "Please enter the name of the toilet."),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 3),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ListTile(
                                      leading: Icon(
                                        OMIcons.timer,
                                        color: ToiletColors.colorPurple,
                                        size: 29.0,
                                      ),
                                      title: Container(
                                        alignment: Alignment.topLeft,
                                        height: 50,
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RaisedButton(
                                              elevation: 0,
                                              color: Colors.white,
                                              onPressed: _selectTime,
                                              padding: EdgeInsets.all(0.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "เปิดเมื่อ  ${_time.format(context)}",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      // fontWeight: FontWeight.w600,
                                                      fontSize: 11,
                                                      fontFamily: 'Sukhumvit' ??
                                                          'SF-Pro',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.grey[900],
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 13,
                                            ),
                                            RaisedButton(
                                              elevation: 0,
                                              color: Colors.white,
                                              onPressed: _selectTime2,
                                              padding: EdgeInsets.all(0.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "ปิดเมื่อ  ${_time2.format(context)}",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      // fontWeight: FontWeight.w600,
                                                      fontSize: 11,
                                                      fontFamily: 'Sukhumvit' ??
                                                          'SF-Pro',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.grey[900],
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        leading: Icon(
                                          OMIcons.info,
                                          color: ToiletColors.colorPurple,
                                          size: 29.0,
                                        ),
                                        title: Container(
                                          height: 150,
                                          child: Row(
                                            children: <Widget>[
                                              Wrap(
                                                direction: Axis.vertical,
                                                children:
                                                    companyWidgets.toList(),
                                              ),
                                              // Text('Selected: ${_filters.join(', ')}'),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    alignment: Alignment.topLeft,
                                    child: ListTile(
                                      leading: Icon(
                                        OMIcons.collections,
                                        color: ToiletColors.colorPurple,
                                        size: 30.0,
                                      ),
                                      title:
                                          Container(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          height: 83,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ToiletColors.colorButton,
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.add_a_photo,
                                              color: Colors.white,
                                            ),
                                            highlightColor: Colors.white,
                                            // onPressed: ()=>!uploading ? chooseImage() : null,
                                            onPressed: () {
                                              tripEditModalBottomSheet(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, top: 5),
                                  child: Container(
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.local_atm,
                                        color: ToiletColors.colorPurple,
                                        size: 30.0,
                                      ),
                                      title: Container(
                                        child: Container(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  showCustomRadio(lst[0], 0),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  showCustomRadio(lst[1], 1),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 250,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                              color:
                                                  ToiletColors.colorButton2)),
                                      onPressed: () async {
                                        //ยืนยัน

                                        List<String> imageUrlList = [];
                                        if (fromKey.currentState.validate()) {
                                          fromKey.currentState.save();
                                          for (var img in _image) {
                                              ref = firebase_storage
                                                  .FirebaseStorage.instance
                                                  .ref()
                                                  .child(
                                                      'images/${Path.basename(img.path)}');
                                              await ref.putFile(img);
                                              final String downloadUrl =
                                                  await ref.getDownloadURL();
                                              imageUrlList.add(downloadUrl);
                                            }

                                          await addToilets.add({
                                            'name': userAddToilet.placesname,
                                            'userName': user.displayName,
                                            'time': timestamp,
                                            'rating': rating,
                                            'openToilet': _time.format(context),
                                            'closeToilet':
                                                _time2.format(context),
                                            'type': _filters.join(', '),
                                            'payment': selectedIndex == 0 &&
                                                    selectedIndex < 1
                                                ? 'ไม่เสียค่าบริการ'
                                                : 'เสียค่าบริการ',
                                            'currentlocation':
                                                "${_currentlocation.latitude},${_currentlocation.longitude}",
                                            'imgAddtoilet': imageUrlList,
                                          });
                                          fromKey.currentState.reset();
                                        }

                                        // Navigator.pushNamed(context, '/o');
                                        Navigator.of(context).pop();
                                      },
                                      padding: EdgeInsets.all(10.0),
                                      color: ToiletColors.colorButton2,
                                      textColor: Colors.white,
                                      child: Text(
                                        "ยืนยัน",
                                        style: TextStyle(
                                          color: Colors.white,
                                          // fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ])));
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  void tripEditModalBottomSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .52,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Add Images"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: ToiletColors.colorButton2,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return index == 0
                              ? Center(
                                  child: IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () =>
                                          !uploading ? chooseImage() : null),
                                )
                              : Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_image[index - 1]),
                                          fit: BoxFit.cover)),
                                );
                        },
                        itemCount: _image.length + 1,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      // RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          side: BorderSide(color: ToiletColors.colorButton2)),
                      onPressed: () async {
                        //ยืนยัน
                        Navigator.of(context).pop();
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
                          fontFamily: 'Sukhumvit' ?? 'SF-Pro',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showCustomRadio(String txt, int index) {
    return Container(
      height: 40,
      width: 130,
      child: OutlineButton(
        onPressed: () => changeIndex(index),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(
            color:
                selectedIndex == index ? ToiletColors.colorPurple : Colors.grey,
            width: 2),
        child: Text(
          txt,
          style: TextStyle(
              color: selectedIndex == index
                  ? ToiletColors.colorPurple
                  : Colors.grey,
              fontFamily: 'Sukhumvit' ?? 'SF-Pro',
              fontSize: 12),
        ),
      ),
    );
  }
}
