import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import 'detail_controller.dart';

class NotificationDetailView extends GetView<NotificationDetailController> {
  NotificationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
        title: Text(
          'ລາຍລະອຽດ',
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.notifications_active_outlined,
              ),
            ),
            title: Text(
              'Title',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              'Detail',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
