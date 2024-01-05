import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade300,
                Colors.white,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/web_shopping.png'),
              Column(children: [
                Text(
                  "MY PACKAGING",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "One Stop Garment Packaging",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ]),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "L O G I N",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: MyBtn.primary_full,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: Text(
                      "R E G I S T E R",
                      style: TextStyle(
                        color: MyColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: MyBtn.primary_outline_full,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
