import 'package:flutter/material.dart';
import 'package:scn_easy/util/images.dart';

class TopNavigationItem extends StatelessWidget {
  final String showImageNormal;
  final Function onTap;

  TopNavigationItem({
    required this.showImageNormal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.bottomBorder),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 3,
                children: [
                  Image.asset(
                    showImageNormal,
                    width: 19,
                    height: 19,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
