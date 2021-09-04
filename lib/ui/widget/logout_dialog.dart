import "package:flutter/material.dart";
import 'package:project/ui/login/login_screen.dart';
import 'package:project/ui/utils/color_utils.dart';
import 'package:project/view_model/auth_view_model.dart';

verifyDiaog(BuildContext context, String title) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Stack(alignment: Alignment.center, children: [
          Material(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                width: 250,
                height: 200,
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          })),
                  SizedBox(height: 30),
                  Text(title ?? "",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("No")),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        shape: StadiumBorder(),
                        child: Text("Yes",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        color: primaryColor,
                        onPressed: () {
                          AuthService().logout();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                ]),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15))),
          )
        ]);
      });
}
