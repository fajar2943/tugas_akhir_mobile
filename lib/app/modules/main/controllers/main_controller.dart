import 'package:tugas_akhir_mobile/app/modules/main/views/favorite_tab.dart';
import 'package:tugas_akhir_mobile/app/modules/main/views/home_tab.dart';
import 'package:tugas_akhir_mobile/app/modules/main/views/profile_tab.dart';
import 'package:tugas_akhir_mobile/app/modules/main/views/transaction_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;

  List pages = [
    HomeTab(),
    TransactionTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(
        initialPage: (Get.arguments != null) ? int.parse(Get.arguments[0]) : 0);
    currentPage.value =
        (Get.arguments != null) ? int.parse(Get.arguments[0]) : 0;
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
