import 'package:tugas_akhir_mobile/app/data/otp_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  TextEditingController txtEmail = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void directOtp() {
    EasyLoading.show();
    var data = {
      "type": "ResetPassword",
      "send_via": "Email",
      "param": txtEmail.text,
    };
    OtpProvider().directOTP(data).then((Response response) {
      var responseBody = response.body;
      if (response.statusCode == 201) {
        box.erase();
        box.write('status', responseBody['status']);
        box.write('id', responseBody['user_id']);
        Get.offAllNamed(Routes.VERIFY);
        Get.snackbar("Success", "OTP telah dikirim ke email anda!",
            backgroundColor: Colors.green[300], colorText: Colors.white);
      } else if (response.statusCode == 422) {
        Get.snackbar("Warning", responseBody['message'],
            backgroundColor: Colors.amber, colorText: Colors.white);
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Internet tidak stabil",
            backgroundColor: Colors.amber, colorText: Colors.white);
      } else {
        Get.snackbar("Warning", "Terjadi kesalahan, coba lagi!",
            backgroundColor: Colors.amber, colorText: Colors.white);
      }
      EasyLoading.dismiss();
    });
  }
}
