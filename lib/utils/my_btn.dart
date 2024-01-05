import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBtn {
  static final primary_full = ElevatedButton.styleFrom(
    // backgroundColor: MyColors.primary,
    fixedSize: Size(Get.width - 30, 45),
  );

  static final primary_outline_full = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    fixedSize: Size(Get.width - 30, 45),
    side: BorderSide(
      width: 2,
      color: MyColors.primary,
    ),
  );

  static final primary = ElevatedButton.styleFrom(
    backgroundColor: MyColors.primary,
    // fixedSize: Size(Get.width - 50, 40),
  );

  static final primary_outline = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    // fixedSize: Size(Get.width - 50, 40),
    side: BorderSide(
      width: 2,
      color: MyColors.primary,
    ),
  );
}
