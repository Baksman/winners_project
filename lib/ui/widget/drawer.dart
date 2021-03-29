import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
import 'package:project/database/local_storage.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/photo_view_screen.dart';
import 'package:project/ui/user_profile_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:project/ui/widget/logout_dialog.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppUser>(context);
    return Container(
      color: primaryColor,
      // width: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: FutureBuilder<List<String>>(
                  future: Future.wait(
                      [LocalStorage.getImageUrl(), LocalStorage.getMatricNo()]),
                  builder: (context, snapshot) {
                    // if (snapshot.hasError) {
                    //   logger.d(snapshot.error);
                    // }
                    if (!snapshot.hasData) {
                      return Transform.translate(
                        offset: Offset(0, 0),
                        child: AwesomeLoader(
                          color: Colors.white,
                          loaderType: AwesomeLoader.AwesomeLoader3,
                        ),
                      );
                    }

                    // AppUser _user = AppUser();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return PhotoViewScreen(
                                  imageUrl: snapshot.data[0],
                                );
                              }));
                            },
                            child: Hero(
                              tag: "img",
                              child: Container(
                                margin: EdgeInsets.only(left: 20, bottom: 10),
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profile_pic.png"))),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data[1])
                      ],
                    );
                  }),
            ),
            _buildItem(context, "Profile", Icons.person, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => EditProfileScreen(AppUser())));
            }),
            _buildItem(context, "Settings", Icons.settings, () {}),
            _buildItem(context, "About", Icons.menu, () {}),
            Spacer(),
            _buildItem(context, "Logout", Icons.logout, () {
              verifyDiaog(context, "Are sure you want to logout");
            }),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    IconData icon,
    Function onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: onPressed,
        child: Container(
          height: 50,
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(width: 14),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
