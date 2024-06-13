import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoItemsFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ບໍ່ມີລາຍການ',
        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
      ),
    );
  }
}
