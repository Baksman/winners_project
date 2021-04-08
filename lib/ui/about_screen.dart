import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';
import 'package:project/ui/utils/color_utils.dart';

import 'animation/login_animation.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1,
                Text(
                  "ABU HOSTEL CORRESPONDER",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.2,
                Text(
                    "A system designed to aid timely response to students complaints, enable hostel management to work on and supervise living conditions within the various halls of residence in Ahmadu Bello University Zaria."),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.5,
                Text(
                    "Get your complaints and reports pertaining hostel issues to the right authorities and get assistance as soon as possible."),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                2.5,
                Text(
                  "OJABO WINNER OCHANYA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                1.9,
                Text(
                  "U16CS1084",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(2.0, Text("COMPUTER SCIENCE DEPARTMENT")),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                2.0,
                Text("FACULTY OF PHYSICAL SCIENCE"),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
