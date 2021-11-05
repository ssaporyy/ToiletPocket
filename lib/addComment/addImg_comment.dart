import 'dart:io';

import 'package:ToiletPocket/blocs/application_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class AddImage1 extends StatefulWidget {
  @override
  _AddImage1State createState() => _AddImage1State();
}

class _AddImage1State extends State<AddImage1> {
  bool uploading = false;
  double val = 0;
  CollectionReference imgRef;
  firebase_storage.Reference ref;

  List<File> _image = [];
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text("Add Images"),
      content: Container(
        alignment: Alignment.topLeft,
        height: 180,
        width: 200,
        child: Row(
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
      ),
      actions: [
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () => Navigator.pop(context, false),
          child: Text('CANCEL'),
        ),
        FlatButton(
          textColor: Color(0xFF6200EE),
          // onPressed:
          //     () {
          //   Navigator.of(context)
          //       .pop();
          // },
          onPressed: () {
            setState(() {
              uploading = true;
            });
            uploadFile().whenComplete(() => Navigator.of(context).pop());
          },
          child: Text('CONFIRM'),
        ),
      ],
    );
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
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

  Future uploadFile() async {
    int i = 1;

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
          i++;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
