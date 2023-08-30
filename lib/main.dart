import 'package:flutter/material.dart';
import 'package:flutterapp/Features/BoilingTime.dart';
import 'package:flutterapp/Features/TodoApp.dart';
import 'package:flutterapp/Features/WaterTracker.dart';
import 'package:flutterapp/Mainpage/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.yellow),

      debugShowCheckedModeBanner: false,
      home:
          WelcomePage()

    );
  }
}

class MyButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularImageButton(imagePath: 'assets/images/3-removebg-preview.png', onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WaterTracker()));
        }),
        CircularImageButton(imagePath: 'assets/images/5-removebg-preview.png', onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BoilingTimerApp()));
        }),
        CircularImageButton(imagePath: 'assets/images/img_1.png', onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TodoApp()));
        }),
      ],
    );
  }
}

class CircularImageButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  CircularImageButton({required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(0),
        primary: Colors.white,
      ),
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80, // You can adjust the color of the icon
      ),
    );
  }
}
