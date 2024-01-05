import 'package:tugas_akhir_mobile/app/data/profile_provider.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  TextEditingController txtName = TextEditingController(text: box.read("name"));
  TextEditingController txtEmail =
      TextEditingController(text: box.read("email"));
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void updateName() {
    EasyLoading.show();
    ProfileProvider().update({'update': 'name', 'value': txtName.text}).then(
        (Response response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        box.write('name', txtName.text);
        Get.snackbar("Success", "Nama berhasil di update.",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else if (response.statusCode == null) {
        Get.snackbar("Warning", "Periksa koneksi internet anda!",
            backgroundColor: Colors.amber, colorText: Colors.white);
        EasyLoading.dismiss();
      }
    });
  }

  void updatePassword() {
    EasyLoading.show();
    ProfileProvider().changePassword({
      'password_baru': newPassword.text,
      'password_lama': oldPassword.text,
      'konfirmasi_password': confirmPassword.text
    }).then((Response response) {
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
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
      }
    });
  }

  void showPass(type) {
    if (type == 'password') {
      showPassword.value = !showPassword.value;
    } else if (type == 'new_password') {
      showConfirmPassword.value = !showConfirmPassword.value;
    } else {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }
}
