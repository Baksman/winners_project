import 'package:flutter/material.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/widget/logout_dialog.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: Container(
                margin: EdgeInsets.only(left: 20, bottom: 10),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile_pic.png"))),
              ),
            ),
            _buildItem(context, "Profile", Icons.settings, () {}),
            _buildItem(context, "Settings", Icons.next_week, () {}),
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
