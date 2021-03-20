import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/utils/color_utils.dart';

Flushbar show_flushbar(String title) {
  Flushbar _flushbar = Flushbar(
    margin: EdgeInsets.all(8),
    title: "Error",
    // titleText: ,
    backgroundColor: primaryColor,
    duration: Duration(seconds: 2),
    message: title ?? "oops",
// messageText: Text(),
    borderRadius: 8,
  );
  return _flushbar;
}
