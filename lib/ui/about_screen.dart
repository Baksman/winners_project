import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:project/ui/utils/color_utils.dart';

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
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: 20,
                child: Marquee(
                  text: "I  💜  U  BABY GIRL--> ",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: 20,
                child: Marquee(
                  text: "STOP CRYING BABY 💜 💜 💜 💜 💜 💜 💜",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                height: 20,
                child: Marquee(
                  text: "IM SORRY BABY 😢😢😢😢",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
