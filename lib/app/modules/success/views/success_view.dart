import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/success_controller.dart';

class SuccessView extends GetView<SuccessController> {
  const SuccessView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 1000,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset('assets/images/morning.png', width: 200),
                    SizedBox(height: 20),
                    Text(
                      "Selamat",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Password anda berhasil di update.",
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.WELCOME);
                  },
                  child: Text(
                    "Ke Halaman Awal & Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: MyBtn.primary_full,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
