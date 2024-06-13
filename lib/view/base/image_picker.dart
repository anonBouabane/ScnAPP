import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../util/images.dart';

class ImagePickerWidget extends StatelessWidget {
  final Uint8List? rawFile;
  final String image;
  final Function onTap;

  ImagePickerWidget({this.rawFile, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      ClipOval(
        child: rawFile != null
            ? Image.memory(rawFile!, width: 33, height: 33, fit: BoxFit.fill)
            : Image.network(
                image,
                width: 33,
                height: 33,
                fit: BoxFit.fill,
                errorBuilder: (_, __, ___) {
                  return Image.asset(Images.profile,
                      width: 33, height: 35, fit: BoxFit.fitHeight);
                },
              ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        top: 0,
        left: 0,
        child: InkWell(
          onTap: onTap as void Function(),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor),
            ),
            child: Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(shape: BoxShape.circle)),
          ),
        ),
      ),
    ]));
  }
}
