import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

class BottomNavItem extends StatelessWidget {
  final String iconDataUnClick;
  final String iconDataClick;
  final Function? onTap;
  final bool isSelected;
  final String? title;

  BottomNavItem({
    required this.iconDataUnClick,
    required this.iconDataClick,
    this.onTap,
    this.isSelected = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 90,
            width: 90,
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
                  // Icon(iconData, color: isSelected ? Theme.of(context).primaryColor : Colors.grey, size: 25),
                  Image.asset(
                    isSelected ? iconDataClick : iconDataUnClick,
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    title.toString().tr,
                    style: robotoRegular.copyWith(
                      color:
                          isSelected ? Colors.redAccent.shade700 : Colors.black,
                      fontSize: Dimensions.fontSizeSmall,
                    ),
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
