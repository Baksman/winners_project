// import '../constants/firebase_constants.dart';
import 'package:project/database/local_storage.dart';
import 'package:project/ui/utils/log_utils.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
// import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<String> uploadUserPicture(String url, File image) async {
    String photoId = Uuid().v4();
    // File compressedImage = await _compressImage(photoId, image);
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

  // static _compressImage(String photoId, File image) async {
  //   final tempDir = await getTemporaryDirectory();
  //   final String path = tempDir.path;
  //   File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //       image.absolute.path, "$path/img_$photoId.jpg",
  //       quality: 70);
  //   return compressedImageFile;
  // }
}
