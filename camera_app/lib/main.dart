//BT19CSE004
//Vedant Ghuge
//CSE A 4th Sem
//Debug Apk Folder Drive Link : https://drive.google.com/drive/folders/1PYpsE65cfQiZKoG423HYP1EWw3MG0qgx?usp=sharing

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:gallery_saver/gallery_saver.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  while (true) {
    var status = await Permission.storage.request();
    if (status.isGranted) break;
  }
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        camera: firstCamera,
      ),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture (BT19CSE004)')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),

        // onPressed: _takePhoto,
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();
            final _storageInfo = await PathProviderEx.getStorageInfo();

            // final directory =
            //     await getExternalStorageDirectory(); // main storage folders path,but only works on android as IOS is not currently supported.
            //final path2 = directory.path;
            final path2 = _storageInfo[0].rootDir;
            //image.saveTo('$path2/DCIM/Camera_App/image.jpg');
            var _uuid = Uuid().v1();
            image.saveTo('$path2/DCIM/Camera/$_uuid.jpg');
            Fluttertoast.showToast(
                msg:
                    "Photo Saved on Internal Storage at \n $path2/DCIM/Camera/$_uuid.jpg",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            // final storage = directory.path;
            // GallerySaver.saveImage(image.path).then((path) {
            // setState(() {
            //   firstButtonText = 'image saved!';
            // });
            // });
            // If the picture was taken, display it on a new screen.
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DisplayPictureScreen(
            //       // Pass the automatically generated path to
            //       // the DisplayPictureScreen widget.
            //       imagePath: image?.path,
            //     ),
            //   ),
            // );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }

//   void _takePhoto() async {
//     ImagePicker;

//     ImagePicker.pickImage(source: ImageSource.camera)
//         .then((File recordedImage) {
//       if (recordedImage != null && recordedImage.path != null) {
//         // setState(() {
//         //   firstButtonText = 'saving in progress...';
//         // });
//         GallerySaver.saveImage(recordedImage.path).then((path) {
//           // setState(() {
//           //   firstButtonText = 'image saved!';
//           // });
//         });
//       }
//     });
//   }
}

// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Display the Picture (BT19CSE004)')),
//       body: Image.file(File(imagePath)),
//     );
//   }
// }
