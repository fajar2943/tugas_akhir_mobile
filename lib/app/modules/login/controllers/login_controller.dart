import 'package:tugas_akhir_mobile/app/data/auth_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  List cartList = [];
  List favoriteList = [];
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  void login() async {
    String fcm_token = "";
    await FirebaseMessaging.instance.getToken().then((value) {
      fcm_token = value!;
    });
    String email = txtEmail.text;
    String password = txtPassword.text;
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong!",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      EasyLoading.show();
      var data = {"email": email, "password": password, "fcm_token": fcm_token};
      AuthProvider().login(data).then((Response response) {
        var responseBody = response.body;
        if (response.statusCode == 200) {
          var data = responseBody['data'];
          if (data['role'] == 'Customer') {
            box.write('id', data['id'].toString());
            box.write('name', data['name']);
            box.write('email', data['email']);
            box.write('role', data['role']);
            box.write('status', data['status']);
            box.write('token', responseBody['access_token']);
            (box.read('status') == 'Verify')
                ? Get.offAllNamed(Routes.VERIFY)
                : Get.offAllNamed(Routes.MAIN);
            box.write('cart', cartList);
            box.write('favorite', favoriteList);
          } else {
            Get.snackbar("Failed", "Akun tidak terdaftar",
                backgroundColor: Colors.amber, colorText: Colors.white);
          }
        } else if (response.statusCode == 401) {
          Get.snackbar("Failed", "Email atau password salah",
              backgroundColor: Colors.amber, colorText: Colors.white);
        } else {
          Get.snackbar("Terjadi Kesalahan", "Coba beberapa saat lagi.",
              backgroundColor: Colors.amber, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  void showPass(type) {
    if (type == 'password') {
      showPassword.value = !showPassword.value;
    } else {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }
}
