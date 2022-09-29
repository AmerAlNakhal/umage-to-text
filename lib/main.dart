import 'package:flutter/material.dart';
import 'package:imagetotext/screens/image_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Image',
      routes: {
        'Image': (context) => ImageScreen(),
      },
    );
  }
}
