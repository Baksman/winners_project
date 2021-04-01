import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/ui/utils/log_utils.dart';

class PermissionHandler {
  static checkIfPermitted(
      Function function, BuildContext context, Permission permission) async {
    // Permission permission = Permission.storage;
    // logger.e(permission.status.);
    if (await permission.isGranted) {
      function();
      return;
    } else if (await permission.isUndetermined) {
      await permission.request();
    } else if (await permission.isDenied) {
      await permission.request();
      return;
    } 
      await openAppSettings();
      // Dialogutils.showDialog(
      //     title: "Settings",
      //     context: context,
      //     dialogType: DialogType.INFO,
      //     description: "Storage permission is required",
      //     cancel: () {
      //       Navigator.pop(context);
      //     },
      //     ok: () async {
      //       await openAppSettings();
      //     });
    
  }
}
