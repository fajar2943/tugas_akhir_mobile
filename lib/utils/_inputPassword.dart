import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

Widget inputPassword(
    {label,
    obscureText = false,
    keyboardType = TextInputType.text,
    suffixIcon,
    controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.primary),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
