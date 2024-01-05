import 'package:tugas_akhir_mobile/app/data/auth_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updatePassword() {
    EasyLoading.show();
    AuthProvider().directSetPassword({
      'user_id': box.read('user_id'),
      'verification_id': box.read('verification_id'),
      'hash': box.read('hash'),
      'password_baru': newPassword.text,
      'konfirmasi_password': confirmPassword.text
    }).then((Response response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        box.erase();
        Get.offAllNamed(Routes.SUCCESS);
        Get.snackbar("Success", "${response.body['message']}",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else if (response.statusCode == 422) {
        Get.snackbar("Warning", "${response.body['message']}",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      } else {
        Get.snackbar("Terjadi Kesalahan", "Coba beberapa saat lagi.",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      }
    });
  }

  void showPass(type) {
    if (type == 'new_password') {
      showPassword.value = !showPassword.value;
    } else if (type == 'confirmPassword') {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }
}
