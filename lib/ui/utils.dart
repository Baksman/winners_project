  import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar show_flushbar(String title ) {
    Flushbar _flushbar = Flushbar(
      margin: EdgeInsets.all(8),
      title: "Error",
      // titleText: ,
      duration: Duration(seconds: 2),
      message: title ?? "oops",
      borderRadius: 8,
    );
    return _flushbar;
  }