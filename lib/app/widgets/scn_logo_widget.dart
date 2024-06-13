import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class ScnLogoWidget extends StatelessWidget {
  const ScnLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.newDesignScnLogo,
      width: 150.w,
      // height: 160.h,
      fit: BoxFit.fill,
    );
  }
}
