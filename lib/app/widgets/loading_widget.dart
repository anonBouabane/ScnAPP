import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.newDesignLoadingLogo);
  }
}
