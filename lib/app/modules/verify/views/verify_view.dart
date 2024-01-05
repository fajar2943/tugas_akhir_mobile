import 'package:tugas_akhir_mobile/app/data/category_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verify_controller.dart';

final box = GetStorage();

class VerifyView extends GetView<VerifyController> {
  const VerifyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: GestureDetector(
              //     onTap: () => Navigator.pop(context),
              //     child: Icon(
              //       Icons.arrow_back,
              //       size: 30,
              //       color: Colors.black54,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/term.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Masukan kode OTP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: controller.txtOTP,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        controller.verify();
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.verify();
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              MyColors.primary),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verifikasi',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Kode dikirim melalui email",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              TextButton(
                onPressed: () {
                  if (box.read('status') != 'ResetPassword') {
                    controller.resendOTP();
                  } else {
                    box.erase();
                    Get.offAllNamed(Routes.FORGOT);
                  }
                },
                child: Text(
                  "Kirim ulang kode",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 18,
              ),

              TextButton(
                onPressed: () {
                  box.erase();
                  Get.offAllNamed(Routes.WELCOME);
                },
                child: Text("Kembali ke halaman awal"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
