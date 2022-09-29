import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imagetotext/widgets/helper.dart';
import 'package:imagetotext/widgets/size_config.dart';
import '../screens/image_screen.dart';

class TextScreen extends StatefulWidget {
  @override
  State<TextScreen> createState() => _TextScreenState();
  final String imageText;

  TextScreen({required this.imageText});
}

class _TextScreenState extends State<TextScreen> {
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
          'Image Text',
          style: TextStyle(
            color: Colors.white60,
            fontSize: SizeConfig.scaleTextFont(30),
          ),
        ),
        leading: Icon(
          CupertinoIcons.back,
          color: Colors.transparent,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.scaleWidth(30),
        ),
        child: Column(
          children: [
            //Text
            Container(
              width: double.infinity,
              height: SizeConfig.scaleHeight(550),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(
                  SizeConfig.scaleWidth(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  SizeConfig.scaleWidth(15),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.imageText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.scaleTextFont(20),
                    ),
                  ),
                ),
              ),
            ),
            //SizedBox(15)
            SizedBox(
              height: SizeConfig.scaleHeight(15),
            ),
            //Copy
            GestureDetector(
              onTap: () async {
                await FlutterClipboard.copy(widget.imageText);
                Helper.showMessage(context, 'Text copied');
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
                    'Copy Text',
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: SizeConfig.scaleTextFont(20),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
