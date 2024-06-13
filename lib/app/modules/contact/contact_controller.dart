import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_model.dart';
import 'contact_service.dart';

class ContactController extends GetxController with StateMixin<ContactModel> {
  final ContactService contactUsService = Get.find<ContactService>();
  RxBool hasCallSupport = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    canLaunchUrl(Uri(scheme: 'tel', path: '123'))
        .then((value) => hasCallSupport.value = value);
  }

  @override
  void onReady() async {
    super.onReady();
    getContactUs();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/100045126554088';
    } else {
      fbProtocolUrl = 'fb://page/100045126554088';
    }

    String fallbackUrl =
        'https://www.facebook.com/profile.php?id=100045126554088';

    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallbackUrl),
            mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        Logger().d(e);
      }
    }
  }

  getContactUs() async {
    change(null, status: RxStatus.loading());
    try {
      var res = await contactUsService.loadContact();
      if (res.statusCode == 200) {
        change(ContactModel.fromJson(res.data), status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception catch (err) {
      change(null, status: RxStatus.error(err.toString()));
    }
  }
}
