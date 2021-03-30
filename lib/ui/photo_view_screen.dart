import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
// import "package:flutter/material.dart";
// import 'package:photo_view/photo_view.dart';
// import 'package:project/model/user_model.dart';

class PhotoViewScreen extends StatelessWidget {
  final String imageUrl;
  final File image;

  ImageProvider _getUserImage() {
    if (image == null) {
      if (imageUrl?.isEmpty ?? true) {
        return AssetImage("assets/images/profile_pic.png");
      }
      return CachedNetworkImageProvider(imageUrl);
    } else {
      return FileImage(image);
    }
  }

  PhotoViewScreen({this.imageUrl, this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Hero(
                tag: "img", child: PhotoView(imageProvider: _getUserImage())),
          ),
          Positioned(
            left: 0,
            top: 15,
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
    );
  }
}
