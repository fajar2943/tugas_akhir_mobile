import 'package:flutter/material.dart';

class MyColors {
  static const Color primary = Color(0xFFF66164);
  static const Color primary2 = Color(0xFFFBB0B2);

  static const Color primary_op = Color.fromARGB(58, 246, 105, 124);

  static const Color warning = Colors.amber;
  static const Color dark = Colors.blueGrey;
  static const Color success = Colors.green;
  static const Color danger = Colors.red;

  Color statusColor(status) {
    if (status == 'warning') {
      return MyColors.warning;
    } else if (status == 'dark') {
      return MyColors.dark;
    } else if (status == 'primary') {
      return MyColors.primary;
    } else if (status == 'success') {
      return MyColors.success;
    }
    return MyColors.danger;
  }
}
