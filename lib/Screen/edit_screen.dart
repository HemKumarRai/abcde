import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:room_finder/Screen/OverViewScreen.dart';

class EditScreen extends StatefulWidget {
  static const routName = 'edit_screen';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  File sampleImage;
  String _myValue;
  String url;
  final formKey = GlobalKey<FormState>();

  _openGalley(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.gallery));
    setState(() {
      sampleImage = picture;
    });
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    var picture = (await ImagePicker.pickImage(source: ImageSource.camera));
    setState(() {
      sampleImage = picture;
    });
    Navigator.pop(context);
  }

  bool validAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
  }

  Future uploadStatusImage(BuildContext context) async {
    print("it is not good");
    if (validAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("Post Images");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + '.jpg').putFile(sampleImage);
      String imageUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print(url);
      saveToDataBase(context, url);
      Navigator.pushNamed(context, RoomsOverviewScreen.routName);
    }
  }

  void saveToDataBase(BuildContext context, url) {
    var dbTimeKey = DateTime.now();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      'image': url,
      'description': _myValue,
      'date': dbTimeKey,
      'time': TimeOfDay.now(),
    };
    ref.child('posts').push().set(data);
    Navigator.pushNamed(context, RoomsOverviewScreen.routName);
  }

  Future<void> _showChildDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text('Make a Choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGalley(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sampleImage == null
          ? Center(child: Text("Let's Go For Adding New Room"))
          : enableUpload(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showChildDialog(context);
        },
        child: Center(
            child: Icon(
          Icons.add_circle,
          size: 40,
        )),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 330,
              width: 660,
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Description",
              ),
              onSaved: (value) {
                _myValue = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text(
                "Add a New Room",
              ),
              onPressed: () {
                uploadStatusImage(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
