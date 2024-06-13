import 'package:flutter/material.dart';

import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image(
              image: AssetImage(Images.scnBackgroundPng),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(Images.logo,
                      height: 160, width: 150, fit: BoxFit.fill),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                    ),
                    child: Text("ຕິດຕໍ່ພວກເຮົາ",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeOverLarge,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16),
                    padding: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.scnBackgroundPng),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(23),
                          bottomRight: Radius.circular(23)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 65,
                          margin: EdgeInsets.only(top: 20, right: 6, left: 6),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.inputBg),
                                  fit: BoxFit.fill)),
                          child: Row(
                            children: [
                              // const Icon(Icons.home_outlined),
                              Image.asset(Images.contactHomeIcon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'ບ. ດອນກອຍ ມ. ສີສັດຕະນາກ ຂ. ນະຄອນຫຼວງວຽງຈັນ',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Divider(height: 20, thickness: 1.5),
                        Container(
                          height: 65,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 20, right: 6, left: 6),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.inputBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(Images.contactPhoneIcon),
                              const SizedBox(width: 10),
                              Text(
                                '020 57281247',
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // const Divider(height: 20, thickness: 1),
                        Container(
                          height: 65,
                          margin: EdgeInsets.only(top: 20, right: 6, left: 6),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.inputBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(Images.contactFacebookIcon),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'SCN Easy',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Divider(height: 20, thickness: 1),
                        Container(
                          height: 65,
                          margin: EdgeInsets.only(top: 20, right: 6, left: 6),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.inputBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(Images.contactWhatsappIcon),
                              const SizedBox(width: 10),
                              Text(
                                '020 57281247',
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
