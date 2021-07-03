// import '../constants/firebase_constants.dart';
import 'package:project/database/local_storage.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class StorageService {
  static Future<String> uploadUserPicture(String url, File image) async {
    String photoId = Uuid().v4();
    if (url.isNotEmpty) {
      RegExp reg = RegExp(r"userProfile_(.*).jpg");
      photoId = reg.stringMatch(url)[1];
    }

    try {
      UploadTask _storageUploadTask = FirebaseStorage.instance
          .ref()
          .child("images/users/userProfile_$photoId.jpg")
          .putFile(image);
      TaskSnapshot storageSnap = await _storageUploadTask;

      String downloadUrl = await storageSnap.ref.getDownloadURL();
      LocalStorage.saveImageUrl(downloadUrl);
      return downloadUrl;
    } catch (e) {
      logger.d(e);
      rethrow;
    }
  }

}
