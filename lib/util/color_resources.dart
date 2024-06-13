import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/theme_controller.dart';

class ColorResources {
  static Color getColombiaBlue(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF92C6FF) : Color(0xFF92C6FF);
  }

  static Color getLightSkyBlue(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF8DBFF6) : Color(0xFF8DBFF6);
  }

  static Color getHintColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF52575C) : Color(0xFF52575C);
  }

  static Color getHarlequin(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF3FCC01) : Color(0xFF3FCC01);
  }

  static Color getCheris(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFE2206B) : Color(0xFFE2206B);
  }

  static Color getTextTitle(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF212629) : Color(0xFF212629);
  }

  static Color getGrey(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFF1F1F1) : Color(0xFFF1F1F1);
  }

  static Color getRed(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFFF5555) : Color(0xFFFF5555);
  }

  static Color getYellow(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFFFAA47) : Color(0xFFFFAA47);
  }

  static Color getHint(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF9E9E9E) : Color(0xFF9E9E9E);
  }

  static Color getGainsBoro(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFE6E6E6) : Color(0xFFE6E6E6);
  }

  static Color textColor() {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF0A0A0A) : Color(0xFF0A0A0A);
  }

  static Color getTextBg(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFF8FBFD) : Color(0xFFF8FBFD);
  }

  static Color getIconBg(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFF9F9F9) : Color(0xFFF9F9F9);
  }

  static Color getHomeBg(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFFCFCFC) : Color(0xFFFCFCFC);
  }

  static Color getImageBg(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFE2F0FF) : Color(0xFFE2F0FF);
  }

  static Color getSellerTxt(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF92C6FF) : Color(0xFF92C6FF);
  }

  static Color getChatIcon(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFD4D4D4) : Color(0xFFD4D4D4);
  }

  static Color getLowGreen(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFEFF6FE) : Color(0xFFEFF6FE);
  }

  static Color getGreen(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF23CB60) : Color(0xFF23CB60);
  }

  static Color getFloatingBtn(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF7DB6F5) : Color(0xFF7DB6F5);
  }

  static Color getPrimary(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Theme.of(context).primaryColor : Theme.of(context).primaryColor;
  }

  static Color getSearchBg(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFF4F7FC) : Color(0xFFF4F7FC);
  }

  static Color getArrowButtonColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFFE8551) : Color(0xFFFE8551);
  }

  static Color getReviewRattingColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF66717C) : Color(0xFF66717C);
  }

  static Color visitShop(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFF3F5F9) : Color(0xFFF3F5F9);
  }

  static Color couponColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFFC8E4FF) : Color(0xFFC8E4FF);
  }

  static Color getGreyBunkerColor(BuildContext context) {
    return Get.find<ThemeController>().darkTheme ? Color(0xFF25282B) : Color(0xFF25282B);
  }

  static const Color BLACK = Color(0xff000000);
  static const Color WHITE = Color(0xffFFFFFF);
  static const Color LIGHT_SKY_BLUE = Color(0xff8DBFF6);
  static const Color HARLEQUIN = Color(0xff3FCC01);
  static const Color CERISE = Color(0xffE2206B);
  static const Color GREY = Color(0xffF1F1F1);
  static const Color RED = Color(0xFFD32F2F);
  static const Color YELLOW = Color(0xFFFFAA47);
  static const Color HINT_TEXT_COLOR = Color(0xff9E9E9E);
  static const Color GAINS_BORO = Color(0xffE6E6E6);
  static const Color TEXT_BG = Color(0xffF3F9FF);
  static const Color ICON_BG = Color(0xffF9F9F9);
  static const Color HOME_BG = Color(0xffF0F0F0);
  static const Color IMAGE_BG = Color(0xffE2F0FF);
  static const Color SELLER_TXT = Color(0xff92C6FF);
  static const Color CHAT_ICON_COLOR = Color(0xffD4D4D4);
  static const Color LOW_GREEN = Color(0xffEFF6FE);
  static const Color GREEN = Color(0xff23CB60);
  static const Color POINT_GREEN = Color(0xff0b6e2f);
  static const Color COLOR_GREY_BUNKER = Color(0xff25282B);
  static const Color GIFT = Color(0xffd02092);
  static const Color CouponColor = Color(0xfffc6969);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor PRIMARY_MATERIAL = MaterialColor(0xFF192D6B, colorMap);
}
