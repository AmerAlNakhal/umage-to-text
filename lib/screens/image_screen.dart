import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetotext/screens/text_screen.dart';
import 'package:imagetotext/widgets/size_config.dart';
import '../screens/image_screen.dart';

class ImageScreen extends StatefulWidget {
  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  // String? imagePath;
  XFile? imageFile;
  String scannedText = "";
  bool textScanning = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900.withOpacity(.8),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900.withOpacity(.01),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pick Image',
          style: TextStyle(
            color: Colors.white60,
            fontSize: SizeConfig.scaleTextFont(30),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.scaleWidth(30),
        ),
        child: Column(
          children: [
            //Image
            Container(
              width: double.infinity,
              height: SizeConfig.scaleHeight(500),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleWidth(25),
                ),
              ),
              child: imageFile != null
                  ? Image.file(File(imageFile!.path),fit: BoxFit.contain)
                  : Center(
                      child: SpinKitSpinningLines(
                        color: Colors.grey.shade900,
                        size: SizeConfig.scaleWidth(90),
                      ),
                    ),
            ),
            //SizedBox(15)
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            //PickImage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //PickImage
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: SizeConfig.scaleWidth(150),
                    height: SizeConfig.scaleHeight(50),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.scaleWidth(15),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Pick Image',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: SizeConfig.scaleTextFont(20),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                //ImageText
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextScreen(
                            imageText: scannedText ?? 'No text in image',
                          ),
                        ));
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: Colors.white70,
                    size: SizeConfig.scaleWidth(50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }
}
