import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/data/model/response/response_model.dart';

import '../../../data/model/response/update_profile.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/message_alert_message.dart';
import 'widgets/condition_check_box.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _phoneController.text = "55454545";
    _phoneController.text = Get.find<AuthController>().getUserNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image(
                image: AssetImage(Images.scnBackgroundPng),
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            GetBuilder<UserController>(builder: (userController) {
              return OverlayLoaderWithAppIcon(
                isLoading: userController.isLoading,
                appIcon: Image.asset(Images.loadingLogo),
                circularProgressColor: Colors.green.shade800,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Image.asset(Images.logo,
                          height: 160, width: 150, fit: BoxFit.fill),
                      Container(
                        height: 290,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.registerBg),
                                fit: BoxFit.fill)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Center(
                                          child: Text("firstName".tr,
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                        ),
                                      ),
                                      // SizedBox(height: 30),
                                      Container(
                                        height: 50,
                                        child: Center(
                                          child: Text("lastName".tr,
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 50,
                                        padding: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: Text("phoneNo".tr,
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                        ),
                                      ),
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.only(top: 32),
                                        child: Center(
                                          child: Text("ເພດ",
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeLarge)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.inputBg),
                                                    fit: BoxFit.fill)),
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: userController
                                                  .firstName.value,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                counterText: '',
                                                contentPadding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 5,
                                                    bottom: 5),
                                              ),
                                              onChanged: (newValue) {
                                                userController
                                                    .getFirstNameLength(
                                                        newValue);
                                              },
                                              keyboardType: TextInputType.text,
                                              style: robotoBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge),
                                              maxLength: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                              "${userController.lengthOfFirstName.length}/30",
                                              style: robotoRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall),
                                            ),
                                          )
                                        ],
                                      ),
                                      // SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.inputBg),
                                                    fit: BoxFit.fill)),
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller:
                                                  userController.lastName.value,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                counterText: '',
                                                contentPadding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 5,
                                                    bottom: 5),
                                              ),
                                              onChanged: (newValue) {
                                                userController
                                                    .getLastNameLength(
                                                        newValue);
                                              },
                                              keyboardType: TextInputType.text,
                                              style: robotoBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge),
                                              maxLength: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                                "${userController.lengthOfLastName.length}/30",
                                                style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall)),
                                          )
                                        ],
                                      ),
                                      // SizedBox(height: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 6.0),
                                                padding:
                                                    EdgeInsets.only(top: 6),
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(Images
                                                          .phonePrefixBox),
                                                      fit: BoxFit.fill),
                                                ),
                                                child: Center(
                                                  child: Text('020',
                                                      style: robotoBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge)),
                                                ),
                                              ),
                                              Flexible(
                                                child: Container(
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            Images.inputBg),
                                                        fit: BoxFit.fill),
                                                  ),
                                                  child: TextFormField(
                                                      readOnly: true,
                                                      controller:
                                                          _phoneController,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        // isDense: true,
                                                        counterText: '',
                                                        // contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      style: robotoBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge),
                                                      maxLength: 8),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: Text(
                                                "${_phoneController.text.length}/8",
                                                style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: RadioListTile(
                                              title: Text("ຊາຍ"),
                                              value: "m",
                                              groupValue: userController.gender,
                                              onChanged: (value) {
                                                userController.setGender(value);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: RadioListTile(
                                              title: Text("ຍິງ"),
                                              value: "f",
                                              groupValue: userController.gender,
                                              onChanged: (value) {
                                                userController.setGender(value);
                                                // });
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child:
                            ConditionCheckBox(authController: userController),
                      ),
                      InkWell(
                        onTap: () async {
                          if (userController.acceptTerms) {
                            if (userController
                                    .firstName.value.text.isNotEmpty &&
                                userController.lastName.value.text.isNotEmpty) {
                              await _register(userController);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => MessageAlertMsg(
                                  'error',
                                  'fillTheForm',
                                  Icons.error_outline,
                                  Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: userController.acceptTerms
                            ? Container(
                                height: 60,
                                // width: MediaQuery.of(context).size.width / 1.4,
                                width: MediaQuery.of(context).size.width /
                                    (context.isTablet ? 2 : 1.5),
                                // margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Images.registerBtn),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width /
                                    (context.isTablet ? 2 : 1.5),
                                // margin: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "ລົງທະບຽນ",
                                    style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _register(UserController userController) async {
    String _firstName = userController.firstName.value.text;
    String _lastName = userController.lastName.value.text;
    String _phoneNumber = _phoneController.text.trim();
    String gender = userController.gender;

    UserProfile _updatedUser = UserProfile(
        firstname: _firstName,
        lastname: _lastName,
        phone: _phoneNumber,
        gender: gender);
    ResponseModel _responseModel =
        await userController.updateUserInfo(_updatedUser);

    if (_responseModel.isSuccess) {
      Get.offAllNamed(RouteHelper.getDashboardRoute());
      userController.firstName.value.clear();
      userController.lastName.value.clear();
      _phoneController.clear();
      showDialog(
        context: context,
        builder: (context) => MessageAlertMsg(
          'success',
          'register_success',
          Icons.check_circle,
          Colors.green,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => MessageAlertMsg(
          'error',
          _responseModel.message,
          Icons.error_outline,
          Colors.red,
        ),
      );
    }
  }
}
