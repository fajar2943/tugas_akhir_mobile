import 'package:tugas_akhir_mobile/app/data/auth_provider.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/helper.dart';

class RegisterController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  var term = false.obs;
  List cartList = [];
  List favoriteList = [];
  RxBool showPassword = true.obs;
  RxBool showConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void index() {}

  void register() async {
    if (txtPassword.text.length < 8) {
      Get.snackbar("Warning", "Password minimal 8 huruf",
          backgroundColor: Colors.amber, colorText: Colors.white);
    } else if (txtPassword.text != txtConfirmPassword.text) {
      Get.snackbar("Warning", "Password tidak sesuai",
          backgroundColor: Colors.amber, colorText: Colors.white);
    } else if (!term.value) {
      Get.snackbar("Warning", "Pastikan anda sudah menyetujui kebijakan kami",
          backgroundColor: Colors.amber, colorText: Colors.white);
    } else {
      EasyLoading.show();
      String fcm_token = "";
      await FirebaseMessaging.instance.getToken().then((value) {
        fcm_token = value!;
      });
      var data = {
        'nama': txtName.text,
        'email': txtEmail.text,
        'password': txtPassword.text,
        'fcm_token': fcm_token
      };
      AuthProvider().register(data).then((Response response) {
        var responseBody = response.body;
        if (response.statusCode == 422) {
          Get.snackbar("Warning", responseBody['message'],
              backgroundColor: Colors.amber, colorText: Colors.white);
        } else if (response.statusCode == 201) {
          var data = responseBody['data'];
          box.write('id', data['id'].toString());
          box.write('name', data['name']);
          box.write('email', data['email']);
          box.write('role', data['role']);
          box.write('status', data['status']);
          box.write('token', responseBody['access_token']);
          Get.offAllNamed(Routes.VERIFY);
          box.write('cart', cartList);
          box.write('favorite', favoriteList);
        } else if (response.statusCode == 500) {
          Get.snackbar("Warning", "Ada masalah server!",
              backgroundColor: Colors.amber, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  void setTerm(var value) {
    term.value = value;
  }

  void showPass(type) {
    if (type == 'password') {
      showPassword.value = !showPassword.value;
    } else {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }
}
