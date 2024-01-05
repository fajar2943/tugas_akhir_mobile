import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/utils/_input.dart';
import 'package:tugas_akhir_mobile/utils/_inputPassword.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
          padding: EdgeInsets.all(20),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/morning.png', width: 200),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Login sekarang dan mulailah berbelanja!",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    input(
                        label: "Email",
                        controller: controller.txtEmail,
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(),
                    Obx(
                      () => inputPassword(
                          label: "Password",
                          controller: controller.txtPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.showPass('password');
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          obscureText: controller.showPassword.value),
                    ),
                    SizedBox(),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: MyBtn.primary_full,
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.FORGOT);
                  },
                  child: Text(
                    "Lupa password?",
                    style: TextStyle(color: MyColors.primary),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
