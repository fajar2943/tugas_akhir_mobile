import 'package:tugas_akhir_mobile/my_storage.dart';
import 'package:tugas_akhir_mobile/app/routes/app_pages.dart';
import 'package:tugas_akhir_mobile/style.dart';
import 'package:tugas_akhir_mobile/utils/my_btn.dart';
import 'package:tugas_akhir_mobile/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: MyColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profile",
                          style: h1,
                        ),
                        Icon(
                          IconlyLight.profile,
                          color: Colors.white,
                          size: 33,
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                box.read('name'),
                                style: h3Black,
                              ),
                              Text(
                                box.read('email'),
                                style: h4Dark,
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.offAllNamed(Routes.EDIT_PROFILE);
                                },
                                child: Text("Edit Profile"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    // Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(15),
                    //   ),
                    //   child: Center(
                    //       child: Column(
                    //     children: [Text("Ubah ")],
                    //   )),
                    // ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        box.erase();
                        Get.offAllNamed(Routes.WELCOME);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // style: MyBtn.primary_full,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
