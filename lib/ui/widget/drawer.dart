import 'package:awesome_loader/awesome_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project/database/database_service.dart';
// import 'package:project/database/local_storage.dart';
import 'package:project/model/user_model.dart';
import 'package:project/ui/about_screen.dart';
import 'package:project/ui/photo_view_screen.dart';
import 'package:project/ui/user_profile_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
// import 'package:project/ui/utils/log_utils.dart';
import 'package:project/ui/widget/logout_dialog.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);

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
              child: FutureBuilder<AppUser>(
                  future: DatabaseService.getUserData(appUser.uuid),
                  builder: (context, snapshot) {
                    // if (snapshot.hasErrgit or) {
                    //   logger.d(snapshot.error);
                    // }
                    if (!snapshot.hasData) {
                      return AwesomeLoader(
                        color: Colors.white,
                        loaderType: AwesomeLoader.AwesomeLoader3,
                      );
                    }

                    // AppUser _user = AppUser();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) {
                                return PhotoViewScreen(
                                  imageUrl: snapshot.data.imageUrl,
                                );
                              }));
                              setState(() {});
                            },
                            child: Hero(
                              tag: "img",
                              transitionOnUserGestures: true,
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
                                        fit: BoxFit.cover,
                                        image: snapshot.data.imageUrl.isEmpty
                                            ? AssetImage(
                                                "assets/images/profile_pic.png")
                                            : CachedNetworkImageProvider(
                                                snapshot.data.imageUrl))),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Transform.translate(
                            offset: Offset(10, 0),
                            child: Text(
                              snapshot.data.matricNumber,
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    );
                  }),
            ),
            _buildItem(context, "Profile", Icons.person, () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => EditProfileScreen(AppUser())));
              setState(() {});
            }),
            // _buildItem(context, "Settings", Icons.settings, () {}),
            _buildItem(context, "About", Icons.menu, () async {
              await Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AboutScreen()));
              setState(() {});
            }),
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
