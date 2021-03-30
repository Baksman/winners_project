import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:kt_drawer_menu/kt_drawer_menu.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/database/database_service.dart';
import 'package:project/database/local_storage.dart';
import 'package:project/model/complaint_model.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/all_complaint_screen.dart';
import 'package:project/ui/complaint_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/widget/drawer.dart';
import 'package:provider/provider.dart';

import 'animation/login_animation.dart';
// import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<AppUser>(context);
    return KTDrawerMenu(
      width: 140.0,
      radius: 10.0,
      scale: 0.8,
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
    final uuid = Provider.of<AppUser>(context).uuid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashbaord"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              KTDrawerMenu.of(context).openDrawer();
            }),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FutureBuilder<Object>(
                      future: LocalStorage.getUserName(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return AwesomeLoader(
                            color: Colors.white,
                            loaderType: AwesomeLoader.AwesomeLoader3,
                          );
                        return Center(
                          child: Text(
                            snapshot.data,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FadeAnimation(
                1,
                Text(
                  "ABU HOSTEL CORRESPONDER",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height / 7),
              FadeAnimation(
                1.2,
                GestureDetector(
                  onTap: () {
                    // ComplaintScreen
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ComplaintScreen()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("New complaint",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FadeAnimation(
                1.5,
                GestureDetector(
                  // AllComplaintScreen
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: AllComplaintScreen()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_sharp,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("All complaint",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Transform.translate(
                offset: Offset(10, 0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Recent complaint",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),

              FutureBuilder(
                  future: DatabaseService.getRecentComplaints(uuid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: AwesomeLoader(
                          color: primaryColor,
                          loaderType: AwesomeLoader.AwesomeLoader3,
                        ),
                      );
                    }
                    List<Complaint> complaint = snapshot.data;
                    if (complaint.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Text("You dont have any complaint yet"),
                      );
                    }
                    return Text("yeahj");
                  })
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
      ),
    );
  }
}
