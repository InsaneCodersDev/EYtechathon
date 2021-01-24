import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
// import 'package:vaccinemgmt/addnew.dart';
// import 'package:vaccinemgmt/homePage.dart';
// import 'package:vaccinemgmt/items_page.dart';
// import 'package:provider/provider.dart';
// import 'package:vaccinemgmt/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccinemgmt/globals.dart' as global;
import 'package:vaccinemgmt/shared/loading.dart';
import 'package:vaccinemgmt/item_detail.dart';
import 'package:vaccinemgmt/homePage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;
  bool loading = false;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        // ratioX: 1.0,
        // ratioY: 1.0,
        // maxWidth: 512,
        // maxHeight: 512,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://donationapp-89333.appspot.com');

  Future<String> _startUpload(file) async {
    /// Unique file name for the file
    String fileName = DateTime.now().toString();
    String filePath = 'images/${fileName}';
    await _storage.ref().child(filePath).putFile(file);
    print(' THis is File name ..........images/${fileName}');
    var ref = await Future.value(_storage.ref().child("images/" + fileName));
    return await ref.getDownloadURL();
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    // final globaldata = Provider.of<GlobalData>(context);
    return loading == true
        ? Center(child: Loading())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              elevation: 0.0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Text('Upload Item Photo',
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 20.0,
                      color: Colors.white)),
            ),
            backgroundColor: Colors.black87,

            // Select an image from the camera or gallery
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.black87,
              items: [
                BottomNavigationBarItem(
                  label: "Camera",
                  icon: MaterialButton(
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      }),
                ),
                BottomNavigationBarItem(
                  label: "Gallery",
                  icon: MaterialButton(
                      child: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      }),
                ),
              ],
            ),

            // Preview the image and crop it
            body: ListView(
              children: <Widget>[
                if (_imageFile != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.file(
                      _imageFile,
                      height: 350,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(Icons.crop, color: Colors.white),
                        onPressed: _cropImage,
                        color: Color.fromRGBO(49, 39, 79, 1),
                      ),
                      FlatButton(
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        color: Color.fromRGBO(49, 39, 79, 1),
                        onPressed: _clear,
                      ),
                    ],
                  ),
                  "addnew" == "addnew"
                      ?
                      // FoodList().buildFoodCard(
                      //     context, _imageFile.path, "Towels", 100, 100, true),
                      // Uploader(file: _imageFile)
                      Container(
                          margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: FlatButton.icon(
                            label: Text(
                              'Get Preview',
                              style: TextStyle(color: Colors.white),
                            ),
                            icon: Icon(
                              Icons.post_add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => ItemDetail(
                              //         qty: 10,
                              //         cookiename: "Hello",
                              //         username: "G1234",
                              //         mssg: "global.itempickup",
                              //         assetPath: _imageFile)));
                            },
                          ),
                        )
                      : Text("File Loaded"),
                  Container(
                    margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromRGBO(49, 39, 79, 1),
                    ),
                    child: FlatButton.icon(
                      label: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.cloud_upload,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: 'Confirm Upload',
                          desc: 'Once Uploaded the change will be permanent!',
                          btnCancelOnPress: () {
                            setState(() {
                              loading = false;
                            });
                            Navigator.of(context, rootNavigator: true)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => new HomePage()));
                          },
                          btnOkOnPress: () async {
                            // if ("user" == 'user') {
                            //   global.imgurl = await _startUpload(_imageFile);
                            //   await global.userinst
                            //       .update({'img': global.imgurl});
                            // } else {
                            //   print("from add new");
                            //   global.itemphoto = await _startUpload(_imageFile);
                            //   await global.userinst.update({
                            //     'items': FieldValue.arrayUnion([
                            //       {
                            //         'itemname': global.itemname,
                            //         'itempickup': global.itempickup,
                            //         'itemcount': global.itemcount,
                            //         'itemcategory': global.itemcategory,
                            //         'itemphoto': global.itemphoto,
                            //         'ngoname': global.username,
                            //         'uid': global.uid
                            //       }
                            //     ])
                            //   });

                            //   global.itemname = "";
                            //   global.itempickup = "";
                            //   global.itemcount = "0";
                            //   global.itemcategory = 0;
                            //   global.itemphoto = "";
                            // }
                            // global.getdata();
                            // setState(() {
                            //   loading = false;
                            // });
                            // Navigator.of(context, rootNavigator: true)
                            //     .pushReplacement(MaterialPageRoute(
                            //         builder: (context) => new HomePage()));
                          },
                        )..show();
                      },
                    ),
                  ),
                ],
              ],
            ),
          );
  }
}
