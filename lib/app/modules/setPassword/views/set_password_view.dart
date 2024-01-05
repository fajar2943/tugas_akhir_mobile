import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/_inputPassword.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/set_password_controller.dart';

class SetPasswordView extends GetView<SetPasswordController> {
  const SetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => Container(
            padding: EdgeInsets.all(10),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Ubah Password",
                        style: h3Black,
                      ),
                    ),
                    SizedBox(height: 20),
                    inputPassword(
                        label: "Password baru",
                        controller: controller.newPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showPass('new_password');
                          },
                          icon: Icon(Icons.remove_red_eye),
                        ),
                        obscureText: controller.showPassword.value),
                    SizedBox(),
                    inputPassword(
                        label: "Konfirmasi Password",
                        controller: controller.confirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.showPass('confirmPassword');
                          },
                          icon: Icon(Icons.remove_red_eye),
                        ),
                        obscureText: controller.showConfirmPassword.value),
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        controller.updatePassword();
                      },
                      child: Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: MyBtn.primary_full,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          box.erase();
                          Get.offAllNamed(Routes.WELCOME);
                        },
                        child: Text("Batalkan ubah password"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
