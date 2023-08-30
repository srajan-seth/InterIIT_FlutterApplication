import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/text/colors.dart';
import 'package:flutterapp/text/large_text.dart';
import 'package:flutterapp/text/text.dart';
import '../Features/BoilingTime.dart';
import '../Features/TodoApp.dart';
import '../Features/WaterTracker.dart';
import '../main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> images = [
    'assets/images/img_15.png',
    'assets/images/img_2.png',
    'assets/images/img_3.png',
    'assets/images/img_14.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: (_, index) {
          final bool isFirstScreen = index == 0;
          final bool isSecondScreen = index == 1;
          final bool isThirdScreen = index == 2;
          final bool isFourthScreen = index == 3;

          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isFirstScreen) AppLargeText(text: "About Us"),
                      if (isFirstScreen) SizedBox(height: 5),
                      if (isFirstScreen) AppText(text: 'Flutter Application For INTER IIT PS', size: 15),
                      if (isFirstScreen) SizedBox(height: 20),
                      if (isFirstScreen)
                        Container(
                          width: 250,
                          child: AppText(
                            text: 'Welcome to Flutter Application!!\nThe application contains different HealthTech, EdTech and FoodTech.\nPlease scroll down to explore',
                            color: Colors.black38,
                            size: 14,
                          ),
                        ),
                      if (isFirstScreen) SizedBox(height: 420),
                      if (isFirstScreen) AppLargeText(text: "Swap Down!!"),

                      if (isSecondScreen) AppLargeText(text: "Water Tracker"),
                      if (isSecondScreen) SizedBox(height: 5),
                      if (isSecondScreen) AppText(text: 'You can track the amount of water \nyou drink throughout the day', size: 15),

                      if (isSecondScreen) SizedBox(height: 20),
                      if (isSecondScreen)
                        Container(
                          width: 250,
                          child: AppText(
                            text: 'HealthTech Feature',
                            color: Colors.black,
                            size: 14,
                          ),
                        ),
                      if (isSecondScreen) SizedBox(height: 40),


                      if (isThirdScreen) AppLargeText(text: "Boiling Timer"),
                      if (isThirdScreen) SizedBox(height: 5),
                      if (isThirdScreen) AppText(text: 'You can track the time for boiling the food item', size: 15),
                      if (isThirdScreen) SizedBox(height: 20),
                      if (isThirdScreen)
                        Container(
                          width: 250,
                          child: AppText(
                            text: 'FoodTech Feature',
                            color: Colors.black,
                            size: 14,
                          ),
                        ),
                      if (isThirdScreen) SizedBox(height: 40),

                      if (isFourthScreen) AppLargeText(text: "To-Do App"),
                      if (isFourthScreen) SizedBox(height: 5),
                      if (isFourthScreen) AppText(text: 'You can track the tasks you want to do in a day', size: 15),
                      if (isFourthScreen) SizedBox(height: 20),
                      if (isFourthScreen)
                        Container(
                          width: 250,
                          child: AppText(
                            text: 'EdTech Feature',
                            color: Colors.black,
                            size: 14,
                          ),
                        ),
                      if (isFourthScreen) SizedBox(height: 40),

                      if (isSecondScreen)
                        CircularImageButton(
                          imagePath: 'assets/images/3-removebg-preview.png',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WaterTracker()));
                          },
                        ),

                      if (isThirdScreen)
                        CircularImageButton(
                          imagePath: 'assets/images/5-removebg-preview.png',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BoilingTimerApp()));
                          },
                        ),

                      if (isFourthScreen)
                        CircularImageButton(
                          imagePath: 'assets/images/img_1.png',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TodoApp()));
                          },
                        ),
                    ],
                  ),
                  Column(
                    children: List.generate(4, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index == indexDots ? 25 : 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index == indexDots ? AppColors.mainColor : AppColors.mainColor.withOpacity(0.3),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
