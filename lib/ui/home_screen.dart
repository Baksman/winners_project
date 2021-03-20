import 'package:flutter/material.dart';
import 'package:project/ui/utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbaord"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "winner",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "ABU HOSTEL CORRESPONDER",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: height / 5),
          ],
        ),
      ),
    );
  }
}
