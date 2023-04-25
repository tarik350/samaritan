import 'dart:io';
import 'package:project_samaritan/pages/medicine_Description.dart';
import 'package:project_samaritan/resources/camera_methods.dart';
import 'package:project_samaritan/resources/text_recognizer.dart';
import '../models/post.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';

// A widget that displays the picture taken by the user.
var scannedText;
var SearchedText;

// ignore: must_be_immutable
class DisplayPictureScreen extends StatefulWidget {
  String imagePath;

  DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool textScanning = false;
  Post? posts;
  Future<Null> _cropImage() async {
    CroppedFile? croppedFile = await CameraMethods.cropImage(widget.imagePath);
    if (croppedFile != null) {
      setState(() {
        widget.imagePath = croppedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Image.file(File(widget.imagePath)),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              heroTag: 'cropper_button',
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 31, 8, 82),
                          Colors.deepPurple,
                        ])),
                child: const Icon(
                  Icons.crop,
                  size: 30,
                ),
              ),
              onPressed: () {
                _cropImage();
              },
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: 'navigator_button',
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 31, 8, 82),
                            Colors.deepPurple,
                          ])),
                  child: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
                onPressed: () async {
                  // await getRecognisedText(XFile(widget.imagePath));

                  //we can further modify this to use bloc architecture
                  // for now we are simply passing the value upon navigation
                  scannedText = await TextReconitionModel.getRecognisedText(
                      XFile(widget.imagePath));

                  //why do we need this line
                  if (!mounted) return;
                  // this where we navigate to medicine description page

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return MedicineDescription(
                      imagePath: widget.imagePath,
                      medName: scannedText,
                    );
                  }));
                },
              ))
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // getRecognisedText(XFile image) async {
  //   final inputImage = InputImage.fromFilePath(image.path);
  //   final textDetector = GoogleMlKit.vision.textRecognizer();
  //   RecognizedText recognisedText = await textDetector.processImage(inputImage);
  //   await textDetector.close();
  //   scannedText = "";
  //   for (TextBlock block in recognisedText.blocks) {
  //     for (TextLine line in block.lines) {
  //       scannedText = scannedText + line.text + "\n";
  //     }
  //   }

  //   print("==========================================" +
  //       scannedText +
  //       "++++++++++++++++++++++++++");
  //   textScanning = false;
  //   setState(() {});
  // }
}
