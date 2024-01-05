import 'package:tugas_akhir_mobile/utils/_inputPassword.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_akhir_mobile/utils/_input.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Container(
          height: 1000,
          padding: const EdgeInsets.all(20),
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
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/term.png', width: 150),
                      Text(
                        "Daftar Sekarang!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Dapatkan kemudahan berbelanja di toko kami.",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      input(
                          label: "Nama Lengkap",
                          controller: controller.txtName),
                      SizedBox(),
                      input(
                          label: "Email",
                          controller: controller.txtEmail,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(),
                      inputPassword(
                          label: "Password",
                          controller: controller.txtPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPass('password');
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          obscureText: controller.showPassword.value),
                      SizedBox(),
                      inputPassword(
                          label: "Konfirmasi Password",
                          controller: controller.txtConfirmPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPass('confirmPassword');
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          obscureText: controller.showConfirmPassword.value),
                      SizedBox(),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.term.value,
                              onChanged: (value) {
                                controller.setTerm(value);
                              }),
                          Text(
                              'Saya menyetujui Ketentuan Layanan\ndan Privacy Policy.')
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.register();
                    },
                    child: Text(
                      "Daftar",
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
      ),
    );
  }
}
