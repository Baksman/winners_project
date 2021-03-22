import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/widget/drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KTDrawerMenu(
    width: 140.0,
      radius: 10.0,
      scale: 0.8,
      shadow: 20.0,

      content: HomeScreen(),
      drawer: DrawerWidget(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// WavyAnimatedTextKit(
//   textStyle: TextStyle(
//         fontSize: 32.0,
//         fontWeight: FontWeight.bold
//     ),
//   text: [
//     "Hello World",
//     "Look at the waves",
//   ],
//   isRepeatingAnimation: true,
// ),
class _HomeScreenState extends State<HomeScreen> {
  // final a = KTDrawerMenu(
  //   width: 360.0,
  //   radius: 30.0,
  //   scale: 0.6,
  //   shadow: 20.0,
  //   shadowColor: Colors.black12,
  //   drawer: DrawerPage(),
  //   content: HomePage(),
  // );
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbaord"),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              KTDrawerMenu.of(context).openDrawer();
            }),
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
         
            // SizedBox(
            //   width: 350.0,
            //   child: TextLiquidFill(
            //     text: 'ABU HOSTEL CORRESPONDE',
            //     waveColor: Colors.blueAccent,
            //     boxBackgroundColor: primaryColor,
            //     textStyle: TextStyle(
            //       fontSize: 20.0,
            //       fontWeight: FontWeight.bold,
            //     ),
            //     boxHeight: 300.0,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
