import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/notification/notification_model.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:selectable_autolink_text/selectable_autolink_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.red.shade50,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.redAccent.shade700,
            title: Text(
              'ລາຍການແຈ້ງເຕືອນ'.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge1,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.getNotifications(),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: controller.obx(
                (state) {
                  return Column(
                    children: [
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state!.notifications!.length,
                        itemBuilder: (context, index) {
                          NotificationItem item = state.notifications![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title!,
                                    style: TextStyle(
                                      fontFamily: 'NotoSansLao',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  SelectableAutoLinkText(
                                    item.body!,
                                    linkStyle:
                                        TextStyle(color: Colors.blueAccent),
                                    highlightedLinkStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      backgroundColor:
                                          Colors.blueAccent.withAlpha(0x33),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'NotoSansLao',
                                    ),
                                    onTap: (url) async {
                                      final uri = Uri.parse(url);
                                      if (await canLaunchUrl(uri)) {
                                        launchUrl(uri);
                                      }
                                    },
                                    onLongPress: (url) async {
                                      await Clipboard.setData(
                                        ClipboardData(text: '${item.body!}'),
                                      );
                                    },
                                    linkRegExpPattern:
                                        '(@[\\w]+|#[\\w]+|${AutoLinkUtils.urlRegExpPattern})',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Text(
                                    'ວັນທີ: ${DateConverter.dateToDateAndTime1(item.pushDate)}',
                                    style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
                onLoading: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.3,
                  ),
                  child: Center(child: CircularProgressIndicator()),
                ),
                onEmpty: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.3,
                  ),
                  child: const Center(child: Text("ບໍ່ມີລາຍການ")),
                ),
                onError: (e) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.height * 0.3,
                    horizontal: 20,
                  ),
                  child: Center(
                    child: Text(
                      "$e",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class NotificationView extends GetView<NotificationController> {
//   NotificationView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NotificationController>(
//       init: NotificationController(),
//       builder: (_) {
//         return Scaffold(
//           backgroundColor: Colors.red.shade50,
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: Colors.redAccent.shade700,
//             title: Text(
//               'ລາຍການແຈ້ງເຕືອນ'.tr,
//               style: robotoBold.copyWith(
//                 fontSize: Dimensions.fontSizeExtraLarge1,
//               ),
//             ),
//           ),
//           body: SingleChildScrollView(
//             physics: AlwaysScrollableScrollPhysics(),
//             padding: EdgeInsets.all(10),
//             child: ListView.separated(
//               itemCount: controller.lstNotifications.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [],
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) => Divider(
//                 height: 1,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
