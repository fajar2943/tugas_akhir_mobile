import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/_input.dart';
import 'package:tugas_akhir_mobile/utils/_inputPassword.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.MAIN, arguments: '3');
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
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
                          "Ubah Nama",
                          style: h3Black,
                        ),
                      ),
                      SizedBox(height: 10),
                      input(
                          label: "Nama Lengkap",
                          controller: controller.txtName),
                      SizedBox(),
                      ElevatedButton(
                        onPressed: () {
                          controller.updateName();
                        },
                        child: Text(
                          "Update",
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
            Container(
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
                      SizedBox(height: 10),
                      inputPassword(
                          label: "Password saat ini",
                          controller: controller.oldPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPass('password');
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          obscureText: controller.showPassword.value),
                      Divider(),
                      SizedBox(),
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
