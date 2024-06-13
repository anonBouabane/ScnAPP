import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/data/model/response/update_profile.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/base/message_alert_message.dart';
import 'package:scn_easy/view/screens/profile/widgets/selected_bank_dialog.dart';

import '../../../util/images.dart';
import '../../widgets/background_widget.dart';
import 'profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('ຂໍ້ມູນສ່ວນຕົວ'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (controller) {
              return OverlayLoaderWithAppIcon(
                isLoading: controller.isLoading.value,
                appIcon: Image.asset(Images.loadingLogo),
                circularProgressColor: Colors.green.shade800,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      showUserProfileUpdate(controller, context),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget showUserProfileUpdate(
      ProfileController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset(
          Images.logo,
          height: 160,
          width: 150,
          fit: BoxFit.fill,
        ),
        !controller.isEditProfile.value
            ? buildWidgetBeforeEditProfile(controller)
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(Images.profileBg),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 20,
                ),
                height: 390,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ---------- start update by thin ---------- //
                      buildFirstNameTextFormField(controller),
                      SizedBox(height: 10),
                      buildLastNameTextFormField(controller),
                      SizedBox(height: 10),
                      buildPhoneTextFormField(controller),
                      SizedBox(height: 10),
                      buildBankNameTextFormField(controller),
                      SizedBox(height: 10),
                      buildBankAccountNameTextFormField(controller),
                      SizedBox(height: 10),
                      buildBankAccountNumberTextFormField(controller),
                      // ---------- end update by thin ---------- //
                    ],
                  ),
                ),
              ),
        // --------------- start update by thin --------------- //
        buildButton(controller, context),
        // ------------- end update by thin ------------ //
      ],
    );
  }

  Widget buildWidgetBeforeEditProfile(ProfileController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(Images.profileBg),
          fit: BoxFit.fill,
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
      height: 180,
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "firstName".tr,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 25),
                    Text(
                      "phoneNo".tr,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.inputBg),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.txtUsername,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.inputBg),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextFormField(
                          controller: controller.txtMobile,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFirstNameTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "firstName".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtFirstName,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLastNameTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "lastName".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtLastName,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "phoneNo".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtMobile,
              keyboardType: TextInputType.phone,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankNameTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_name".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtBankName,
              keyboardType: TextInputType.text,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            await showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) => BankListSelected(),
            );
            controller.txtBankName.text =
                Get.find<UserController>().bankName.value.text;
            controller.update();
          },
          child: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Icon(
              Icons.list_alt_outlined,
              size: 40,
              color: Colors.redAccent.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankAccountNameTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_account_name".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtBankAccountName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankAccountNumberTextFormField(ProfileController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_account_no".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: controller.txtBankAccountNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  left: 5,
                ),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.only(left: 4, right: 4),
          child: Icon(
            controller.bankAccountStatus.value != 0
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            size: 40,
            color: controller.bankAccountStatus.value != 0
                ? Colors.green.shade700
                : Colors.redAccent.shade700,
          ),
        ),
      ],
    );
  }

  Widget buildButton(ProfileController controller, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: InkWell(
        onTap: () async {
          if (controller.isEditProfile.value == false) {
            controller.isEditProfile.value = true;
            controller.update();
          } else {
            if (controller.formKey.currentState!.validate()) {
              if (controller.txtFirstName.text.isEmpty ||
                  controller.txtLastName.text.isEmpty ||
                  controller.txtBankAccountNumber.text.isEmpty ||
                  controller.txtBankAccountName.text.isEmpty ||
                  controller.txtBankName.text.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) => MessageAlertMsg(
                    'error',
                    'fillTheForm',
                    Icons.error_outline,
                    Colors.red,
                  ),
                );
              } else {
                UserProfile profile = UserProfile();
                profile.firstname = controller.txtFirstName.text;
                profile.lastname = controller.txtLastName.text;
                profile.bankName = controller.txtBankName.text;
                profile.accountNo = controller.txtBankAccountNumber.text;
                profile.accountName = controller.txtBankAccountName.text;
                profile.phone = controller.txtMobile.text;
                profile.gender = controller.gender.value;
                profile.bankId = Get.find<UserController>().bankId;
                controller.updateUserInfo(profile);
              }
            }
          }
        },
        child: Container(
          // width: MediaQuery.of(context).size.width / 1.2,
          height: 50.0,
          padding: const EdgeInsets.only(left: 8, right: 8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.buttonBg),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Text(
              !controller.isEditProfile.value ? 'edit_profile'.tr : 'save'.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
