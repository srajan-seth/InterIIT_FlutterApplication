import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Features/BoilingTime.dart';
import 'Features/TodoApp.dart';
import 'Features/WaterTracker.dart';
import 'main.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

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
