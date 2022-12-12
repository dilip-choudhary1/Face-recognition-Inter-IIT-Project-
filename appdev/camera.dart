// import 'dart:ffi';

// import 'dart:js';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:interiit/Screens/home_screen.dart';

class Camera extends StatefulWidget {
  //  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? imageFile;

  // void _getFromCamera() async {
  //   XFile? PickedFile = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 600,
  //     maxWidth: 400,
  //   );
  //   setState(() {
  //     var pickedFile = PickedFile;
  //     imageFile = File(pickedFile!.path);
  //   });
  // }

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 76, 20),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          // imageFile != null
          //     ? Container(
          //         child: Image.file(imageFile!),
          //       ):
          Container(
            child: Icon(
              Icons.camera_enhance_rounded,
              color: const Color.fromARGB(255, 250, 205, 3),
              size: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: ElevatedButton(
              child: Text(
                'Capture Image with Camera',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  maxHeight: 600,
                  maxWidth: 400,
                );
                // print('${file?.path}');
                if (file == null) return;

                String uniqueaFilename =
                    DateTime.now().millisecondsSinceEpoch.toString();

                // get a reference to storage root

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference refrenceDirImage = referenceRoot.child('images');
                // create a reference for the image to be stored
                Reference referenceImageToUpload =
                    refrenceDirImage.child(uniqueaFilename);
                try {
                  // store the file
                  await referenceImageToUpload.putFile(File(file.path));
                  // success:get the download URL

                  imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (error) {
                  const SizedBox(
                    height: 20,
                    child: Text('Please upload the image'),
                  );
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 243, 19, 19)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 16,fontWeight: FontWeight.normal))),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: ElevatedButton(
              child: const Text(
                'Back to Home',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyRegister()));
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 243, 19, 19)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 16))),
            ),
          ),
        ],
      ),
    );
  }
}
