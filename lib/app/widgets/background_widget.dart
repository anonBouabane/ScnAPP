import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/generated/assets.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(Assets.imagesScnBackground),
      fit: BoxFit.fill,
      height: Get.height,
      width: Get.width,
    );
  }
}
