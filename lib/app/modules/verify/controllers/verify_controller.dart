import 'package:tugas_akhir_mobile/app/data/otp_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  final box = GetStorage();
  TextEditingController txtOTP = TextEditingController();

  @override
  void onInit() {
    index();
    super.onInit();
  }

  void index() {
    if (box.read('status') != 'ResetPassword') {
      EasyLoading.show();
      OtpProvider().sendOTP({'type': 'Register', 'send_via': 'Email'}).then(
          (Response response) {
        if (response.statusCode == 201) {
          Get.snackbar("Success", "OTP telah dikirim ke email anda!",
              backgroundColor: Colors.green[300], colorText: Colors.white);
        } else if (response.statusCode == 422) {
          Get.snackbar("Failed", "Melampaui batas, silahkan coba lagi besok!",
              backgroundColor: Colors.amber, colorText: Colors.white);
        } else {
          Get.snackbar("Server Error", "Tutup aplikasi dan coba lagi",
              backgroundColor: Colors.amber, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  void verify() {
    EasyLoading.show();
    String type = (box.read('status') == 'ResetPassword')
        ? box.read('status')
        : 'Register';
    OtpProvider().verify({
      'user_id': box.read('id'),
      'otp': txtOTP.text,
      'type': type
    }).then((Response response) {
      if (response.statusCode == 200) {
        var responseBody = response.body;
        if (responseBody['status'] == 'SetPassword') {
          box.erase();
          box.write('status', responseBody['status']);
          box.write('verification_id', responseBody['verification_id']);
          box.write('hash', responseBody['hash']);
          box.write('user_id', responseBody['user_id']);
          Get.offAllNamed(Routes.SET_PASSWORD);
        } else {
          box.write('status', responseBody['status']);
          Get.offAllNamed(Routes.MAIN);
        }
      } else {
        Get.snackbar("Failed", "Kode OTP salah atau kadaluwarsa",
            backgroundColor: Colors.amber, colorText: Colors.white);
      }
      EasyLoading.dismiss();
    });
  }

  void resendOTP() {
    index();
  }
}
